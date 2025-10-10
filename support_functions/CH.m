function eval = CH (D, id_mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input D = n x n distance matrix
%       id = community label
% 
% Output eval 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T. Caliliski and J. Harabasz (1974), A DENDRITE METHOD FOR CLUSTER ANALYSIS 
% Ayoushman Bhattacharya 05.15.2024

K = max(max(id_mat));
[n d] = size(id_mat);
eval = [];

for ii = 1:d
    CH_vec_ii = [];
    for kk = 1:K
%         id_k = find(id_mat(:,ii) == k);
        CH_vec_ii(kk) = sum(D(find(id_mat(:,ii) == kk), find(id_mat(:,ii) == kk)), 'all')/(2*numel(find(id_mat(:,ii) == kk)));
%         clear id_k;
    end
    
    SSW = sum(CH_vec_ii);
    SST = sum(D, 'all')/(2*n);
    SSA = SST - SSW;
    eval(ii) = (SSA/(K-1))/(SSW/(n-K));
    
%     clear CH_vec_ii;
end