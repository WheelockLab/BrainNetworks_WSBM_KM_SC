function[new_id] = rearrange_id(old_id, net_order)
% this function reassigns the network ids in 'old_id' according to the
% sequence specified in 'net_order'.

% Input:
% old_id = idx matrix nROI x n_itr

% net_order = A vector specifying the desired order of network IDs
% if old_id == net_order(jj) then new_id = jj
% Think of it as a mapping table:
%   - the position in net_order = the new label,
%   - the value at that position = the old label to be replaced.
% Example:
% If the old networks are labeled: 1 = blue, 2 = green, 3 = red
% and you want them ordered as: green -> red -> blue
% then: net_order = [2 3 1]
% the mapping means: 
% new label 1 <- old label 2
% new lable 2 <- old label 3
% new label 3 <- old label 1

% Output: new_id = reordered idx

[ nROI, n_itr] = size(old_id);
k_new = max(max(old_id));
new_id = zeros(nROI,n_itr);

if k_new ~= numel(net_order)
    net_order = [net_order (numel(net_order)+1):k_new];
end

for kk = 1:n_itr
    for ii = 1:nROI
        for jj = 1:k_new
            if old_id(ii,kk) == net_order(jj)
                new_id(ii,kk) = jj;
            end
        end
    end
end

end

