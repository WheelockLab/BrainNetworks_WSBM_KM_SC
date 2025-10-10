function [num_u] = num_unique (x)
% function to calculate number of unique elements of a vector

    num_u = length(unique(double(x)));