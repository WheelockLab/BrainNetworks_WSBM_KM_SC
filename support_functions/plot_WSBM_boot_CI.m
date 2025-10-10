function[] = plot_WSBM_boot_CI(boot_res, xtick_vals)
% This function creates the bootstrap confidence interval plots
% boot_res = output from apply_WSBM_boot
% xtick_vals = x axis ticks

if nargin < 2
    xtick_vals = 2:boot_res.valid_k;
end

plot_data(:,2) = reshape(boot_res.loglik_diff(:,2:(boot_res.valid_k-1)), ...
    boot_res.rep*(boot_res.valid_k-2),1);
plot_data(:,1) = reshape(repmat(2:(boot_res.valid_k-1), boot_res.rep,1),...
    boot_res.rep*(boot_res.valid_k-2),1);

 for ii = 2:(boot_res.valid_k-1)
    ci_low(ii-1) = boot_res.confInt(ii,1); 
    ci_up(ii-1) = boot_res.confInt(ii,2);
 end
 
 x = 2:(numel(ci_low)+1);
x2 = [x, fliplr(x)];
inbet_ci = [ci_up, fliplr(ci_low)];

figure();
set(gcf, 'color', 'w');
hold on;
scatter(plot_data(:,1), plot_data(:,2),[], [0.7 0.7 0.7], 'jitter', 'on');
s2 = fill(x2, inbet_ci, [0 0 1],  'EdgeColor', 'none');
alpha(s2, 0.2);
plot(2:boot_res.valid_k, zeros(boot_res.valid_k-1), 'Linewidth', 2, 'color', 'red');
xlabel('K');
ylabel('Difference Loglikelihood');
ax = gca;
ax.FontSize = 20;
xlim([2, boot_res.valid_k + 0.5]);
xticks(xtick_vals);
hold off;

end