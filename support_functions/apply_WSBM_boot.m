function[boot_res] = apply_WSBM_boot(wsbm_results, boot_rep, confInt)
% Inutput: 
% results (wsbm_results) from apply_wsbm
% boot_rep = number of bootstrap samples
% confInt = confidence coefficients, 

% bootstrap on differences of log-likelihood


for k = 2:wsbm_results.K_max
    % for each k, find the valid community assignments
    num_uni = splitapply(@num_unique, ...
        wsbm_results.idx(:,:,k),...
        1:size(wsbm_results.idx, 2));
    valid_rep_id{k} = find(num_uni == k);
    count_valid_rep(k) = length(valid_rep_id{k});
    valid_rep{k} = wsbm_results.idx(:,valid_rep_id{k},k);
    valid_loglik{k} = wsbm_results.log_lik(valid_rep_id{k},k);
end



diffmeans = @(x,y) mean(x) - mean(y);

% Valid K
if length(min(find(count_valid_rep(2:wsbm_results.K_max) == 0))) == 0
    K_valid = wsbm_results.K_max;
else
    K_valid = min(find(count_valid_rep(2:wsbm_results.K_max) == 0));
end

for k = 2:(K_valid-1) 
    % perform the boostrap on the difference of log-likelihood
    if count_valid_rep(k) == count_valid_rep(k+1)
        xk = valid_loglik{k};
        yk = valid_loglik{k+1};
    
    elseif count_valid_rep(k) > count_valid_rep(k+1)
        target_size = count_valid_rep(k+1);
        yk = valid_loglik{k+1};
        xk = datasample(valid_loglik{k}, target_size, 'Replace',false);

    else
        target_size = count_valid_rep(k);
        xk = valid_loglik{k};
        yk = datasample(valid_loglik{k+1}, target_size, 'Replace',false);
    end

    if size(xk,1) == 1
       boot_val = repmat( xk - yk, boot_rep, 1);
    else
        boot_val = bootstrp(boot_rep, diffmeans, xk, yk);
    end
    boot_diff(:,k) = boot_val;
    boot_conf(k,:) = prctile(boot_val, confInt);
end


boot_res.rep = boot_rep;
boot_res.K_max = wsbm_results.K_max;
boot_res.idx = valid_rep;
boot_res.loglik = valid_loglik;
boot_res.count = count_valid_rep;
boot_res.loglik_diff = boot_diff;
boot_res.confInt = boot_conf;
boot_res.valid_k = K_valid;

end