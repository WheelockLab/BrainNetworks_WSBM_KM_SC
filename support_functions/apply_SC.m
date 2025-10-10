function[sc_results] = apply_SC(ave_fcmat, K_max, replication)
% apply Spectral clustering for the average fcmatrix

% Input: 
% ave_fcmat = average fc matrix 
% K_max = maximum value of communities
% replication = number of replication, typically we set 1000

% Output: 
% sc_clustering.idx = (nROI x replication x K_max) matrix containing the
% estimated community labels

idx_mat_sc = []; 

for ii = 1:replication
    start_time_ii = datestr(now);
   parfor k = 2:K_max
%        fprintf('ii=%d \t k=%d \n',ii,k);
       idx = spectralcluster(ave_fcmat, k,'Distance','correlation','LaplacianNormalization','none');

       idx_mat_sc(:,ii,k) = idx;
   end
   end_time_ii = datestr(now);
    total_time_ii = diff(datenum([start_time_ii;end_time_ii]))*24*60; % min
    fprintf('Total time for %d th iteration = %f mins\n', ii,total_time_ii);
end


sc_results.K_max = K_max;
sc_results.replication = replication;
sc_results.idx = idx_mat_sc;


end