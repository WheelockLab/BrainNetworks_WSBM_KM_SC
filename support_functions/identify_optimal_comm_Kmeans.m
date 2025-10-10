function[kmeans_clustering] =  identify_optimal_comm_Kmeans(kmeans_results, ave_fcmat)
% This function indentifies the best Kmeans fits by identifying the community
% assignment with maximum silhoutte coefficient for each k.
% Input: kmeans_results (output from apply_Kmeans())
%        ave_fcmat: average fc matrix

%% Compute the silhouette coefficient

AvgSil = [];

parfor k = 2:kmeans_results.K_max
    stat = Matrix_metrics_HSB(kmeans_results.idx(:,:,k), ave_fcmat); 
    AvgSil(:,k) = stat.AvgSil;
end

%% Choose the best partition according to Max Sil 

idx_final = [];
SIL_final = [];
for k = 2:kmeans_results.K_max
   rep_opt = min(find(AvgSil(:,k) == max(AvgSil(:,k))));
   idx_final(:,k) = kmeans_results.idx(:,rep_opt,k);
   SIL_final(k) = max(AvgSil(:,k));
end

% kmeans_clustering.path = kmeans_results.path;
kmeans_clustering.K_max = kmeans_results.K_max;
kmeans_clustering.idx = idx_final;
kmeans_clustering.SIL = SIL_final;

end