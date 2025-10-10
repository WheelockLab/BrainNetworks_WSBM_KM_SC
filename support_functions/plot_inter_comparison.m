function[] = plot_inter_comparison(val_rep, xtick_vals, y_axis_title, legendVar)
% This function plots the inter comparison for three methods on a given
% metric. 
% Works for NMI, Hamming Distance

% Input:
% val_rep = the structure of values of the post-hoc measures from
% "methods_inter"
% x_tick_vals = Values of K for x-axis
% y_axis_title = name of the post-hoc measure
% legendVar = legend T/F

% Outpot:
% The plots for three methods with Q1 and Q3 confidence bands.
% Kmeans vs Spectral clustering is red
% WSBM vs Spectral clustering is blue
% WSBM vs Kmeans clustering is black

K_valid = size(val_rep.wsbm_sc, 2);


if length(xtick_vals) == 0
    xtick_vals = 2:K_valid;
end

if length(y_axis_title) == 0
    y_axis_title = "Title";
end 


for k = 2:K_valid
   ks_mat{k} = reshape(val_rep.kmeans_sc{k}, prod(size(val_rep.kmeans_sc{k})),1);
   ws_mat{k} = reshape(val_rep.wsbm_sc{k}, prod(size(val_rep.wsbm_sc{k})),1);
   wk_mat{k} = reshape(val_rep.wsbm_kmeans{k}, prod(size(val_rep.wsbm_kmeans{k})),1);
end

val_mat.ks = ks_mat;
val_mat.ws = ws_mat;
val_mat.wk = wk_mat;



for ii =2:K_valid
   ks_med(ii-1) = median(val_mat.ks{ii}); 
   ks_q1(ii-1) = quantile(val_mat.ks{ii}, 0.25);
   ks_q3(ii-1) = quantile(val_mat.ks{ii}, 0.75);
   
   ws_med(ii-1) = median(val_mat.ws{ii}); 
   ws_q1(ii-1) = quantile(val_mat.ws{ii}, 0.25);
   ws_q3(ii-1) = quantile(val_mat.ws{ii}, 0.75);
   
   wk_med(ii-1) = median(val_mat.wk{ii}); 
   wk_q1(ii-1) = quantile(val_mat.wk{ii}, 0.25);
   wk_q3(ii-1) = quantile(val_mat.wk{ii}, 0.75);
end

x = 2:(numel(ks_med)+1);

x2 = [x, fliplr(x)];
inbet_ks = [ks_q3, fliplr(ks_q1)];
inbet_ws = [ws_q3, fliplr(ws_q1)];
inbet_wk = [wk_q3, fliplr(wk_q1)];


figure();
set(gcf, 'color', 'w');
hold on;
s1 = fill(x2, inbet_ks, [1 0 0], 'EdgeColor', 'none');
alpha(s1, 0.1);
s2 = fill(x2, inbet_ws, [0 0 1],  'EdgeColor', 'none');
alpha(s2, 0.1);
s3 = fill(x2, inbet_wk, [0.7 0.7 0.7], 'EdgeColor', 'none' );
alpha(s3, 0.4);
line1 = plot(x, ks_med, 'r', 'Linewidth', 2, 'color', [1 0 0]);
line2 = plot(x, ws_med, 'r', 'Linewidth', 2, 'color', [0 0 1]);
line3 = plot(x, wk_med, 'r', 'Linewidth', 2, 'color', 'black');
xlabel('K');
ylabel(y_axis_title);
 xlim([2 K_valid]);
 ylim('auto');
 xticks(xtick_vals);
 ax = gca;
 ax.FontSize = 20;
 
 
 if legendVar == "T"
     legend([line1 line2 line3], ...
         'Kmeans vs Spectral clustering',...
         'WSBM vs Spectral clustering', ...
         'WSBM vs Kmeans clustering');
 end
hold off;

end