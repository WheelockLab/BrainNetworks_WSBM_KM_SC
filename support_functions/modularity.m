function Q_val = modularity(A,ind_mat)   

[n,d] = size(ind_mat);
Q_val = zeros(d,1);
m = sum(sum(A));
row_sum = sum(A);

parfor dd = 1:d
    % K = max(max(ind_mat(:,dd)));
    % Q = 0;
    for ii = 1:n
        for jj = 1:n
            Q_val(dd) = Q_val(dd) + (A(ii,jj) - (row_sum(ii)*row_sum(jj)/(2*m)) )* (ind_mat(ii,dd) == ind_mat(jj,dd))
        end
    end
end
Q_val = Q_val/(2*m);


end



