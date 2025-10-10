function[consensus] = WSBM_consensus_HD(wsbm_results, K_val)
% this function performs the consensus algorithm on the WSBM assignments
% for a given choice of K. It computes the all pair-wise hamming
% distances between the solution corresponding to the highest logliklihood
% and other solutions. The permuation of community labels that minimizes
% the distance is considered as the new community assignment. Final
% consensus assignments are taken as the mode of the class labels for each
% ROIs. 

% Input: 
% wsbm_results = wsbm assignments from apply_WSBM
% K_val = The choice of K

% Output: 
% consensus.idx = final consensus assignments
% consensus.all_idx = mathed ids for all assignments
% consensus.des_order_idx = mathed ids for all assignments with the
% decreasing order of loglikelihoo values

nROI = size(wsbm_results.idx,1);

% Find the valid solutions for K
    num_uni = splitapply(@num_unique, ...
        wsbm_results.idx(:,:,K_val), 1:size(wsbm_results.idx, 2));
    valid_rep_id = find(num_uni == K_val);
    count_valid_rep = length(valid_rep_id);
    valid_rep = wsbm_results.idx(:,valid_rep_id,K_val);
    valid_loglik = wsbm_results.log_lik(valid_rep_id,K_val);
    
    pivot_id = find(valid_loglik == max(valid_loglik));

    data_cost_mat = [];
    new_ass_mat = zeros(nROI,count_valid_rep);
    
%   
        for jj = 1:count_valid_rep
            if jj == pivot_id
                new_ass_mat(:,jj) = valid_rep(:,jj);
            else

                [ data_labels, ~ , data_cost] = CBIG_HungarianClusterMatch(...
                    valid_rep(:,pivot_id), valid_rep(:,jj), 0);
                new_ass_mat(:,jj) = data_labels;
                data_cost_mat(jj) = 1-(-data_cost/count_valid_rep);
            end
        end
    clear jj data_labels data_cost;

    
    % descending order according to likelihood values 
    [~, des_ord] = sort(valid_loglik, 'descend');

    % take the mode as the final assignment
    consensus.idx = mode(new_ass_mat, 2);
    consensus.all_idx = new_ass_mat; 
    consensus.des_order_idx = new_ass_mat(:,des_ord);
    
end