function[kmeans_results] = apply_Kmeans(ave_fcmat, K_max, replication)
% apply Kmeans for the average fcmatrix

% Input: 
% ave_fcmat = average fc matrix 
% K_max = maximum value of communities
% replication = number of replication, typically we set 1000

% Output: 
% kmeans_clustering.idx = (nROI x replication x K_max) matrix containing the
% estimated community labels

idx_mat_kmeans = []; 

for ii = 1:replication
    start_time_ii = datestr(now);
   parfor k = 2:K_max
%        fprintf('ii=%d \t k=%d \n',ii,k);
       idx = kmeans(ave_fcmat, k,'Distance','correlation');
       idx_mat_kmeans(:,ii,k) = idx;
   end
   end_time_ii = datestr(now);
    total_time_ii = diff(datenum([start_time_ii;end_time_ii]))*24*60; % min
    fprintf('Total time for %d th iteration = %f mins\n', ii,total_time_ii);
end


kmeans_results.K_max = K_max;
kmeans_results.replication = replication;
kmeans_results.idx = idx_mat_kmeans;


end