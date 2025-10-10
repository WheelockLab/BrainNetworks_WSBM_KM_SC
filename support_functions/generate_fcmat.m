function[A] = generate_fcmat(nROI, label_true, mu_mat, sigma_mat, n)
% Input:
% nROI = number of ROIs
% label_true = true label of the ROIs (a vector of length nROI)
% mu_mat = mean matrix (KxK)
% sigma_mat = variance matrix (KxK)
% n = number of subjects

% Output:
% A = fc matrix nROI x nROI x n 

for kk= 1:n
    for ii=1:(nROI)
        for jj=(ii):nROI 
           if ii == jj
               A(ii,jj,kk) = 1;
               A(jj,ii,kk) = 1;
           else
               A(ii,jj,kk) = normrnd( ...
                   mu_mat(label_true(ii),label_true(jj)) ,...
                   sqrt(sigma_mat(label_true(ii),label_true(jj)))...
                   );
               A(jj,ii,kk) = A(ii, jj, kk);
           end
        end
    end
end

end