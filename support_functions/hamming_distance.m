function[x] = hamming_distance(idx1, idx2)
len1 = size(idx1);
len2 = size(idx2);


for ii = 1:len1(2)
    for jj = 1:len2(2)
        [ data_labels, data_assign, data_cost] = CBIG_HungarianClusterMatch(idx1(:,ii), idx2(:,jj), 0);
        x(ii,jj) = 1-(-data_cost/len1(1));
    end
end
end