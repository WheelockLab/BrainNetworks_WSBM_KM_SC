function eval = Cindex (D, id_mat)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input D = n x n distance matrix
%       id = community label
% 
% Output eval 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Milliagan and Cooper 1985
% Ayoushman Bhattacharya 05.15.2024



K = max(max(id_mat));
[n d] = size(id_mat);
eval = [];
sq_D = sqrt(D);

N = numel(sq_D);
N_W = zeros(1,d);
C_vec = zeros(1,d);

for ii = 1:d;
    
    for kk = 1:K
        id_k_ii = find(id_mat(:,ii) == kk);
        N_W(ii) = N_W(ii) + (numel(id_k_ii)*(numel(id_k_ii)-1)/2); 
        C_vec(ii) = C_vec(ii)+ sum(sq_D(id_k_ii, id_k_ii), 'all')/(2);
%         clear id_k;
    end
    
    SW = C_vec(ii);
    sort_sq_D = sort(reshape(sq_D,1, numel(sq_D)), "ascend");
    S_max = sum(sort_sq_D((N-N_W+1):N));
    S_min = sum(sort_sq_D((1+n):(N_W+n)));

    eval(ii) = (SW - S_min)/(S_max - S_min);

end




end