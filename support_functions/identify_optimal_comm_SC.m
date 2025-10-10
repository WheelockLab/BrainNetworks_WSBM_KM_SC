function[sc_clustering] =  identify_optimal_comm_SC(sc_results, ave_fcmat)
% This function indentifies the best spectral clustering fits by identifying the community
% assignment with maximum silhoutte coefficient for each k.
% Input: sc_results (output from apply_SC())
%        ave_fcmat: average fc matrix

%% Compute the silhouette coefficient

AvgSil = [];

parfor k = 2:sc_results.K_max
    stat = Matrix_metrics_HSB(sc_results.idx(:,:,k), ave_fcmat); 
    AvgSil(:,k) = stat.AvgSil;
end

%% Choose the best partition according to Max Sil 

idx_final = [];
SIL_final = [];
for k = 2:sc_results.K_max
   rep_opt = min(find(AvgSil(:,k) == max(AvgSil(:,k))));
   idx_final(:,k) = sc_results.idx(:,rep_opt,k);
   SIL_final(k) = max(AvgSil(:,k));
end

sc_clustering.K_max = sc_results.K_max;
sc_clustering.idx = idx_final;
sc_clustering.SIL = SIL_final;

end