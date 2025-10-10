function [] = mat_plot(A, color_bar, show_ticks)
% Plot a matrix with optional colorbar and axis ticks
%
% Inputs:
%   A          : Matrix to plot
%   color_bar  : 'T' to show colorbar (default: 'F')
%   show_ticks : 'T' to show axis ticks (default: 'F')

% Set default values if not provided
if nargin < 2
    color_bar = 'F';
end
if nargin < 3
    show_ticks = 'F';
end

% Always create a new plot
figure();
set(gcf, 'color', 'w');
colormap(jet(256));
imagesc(A);
axis image;

% Show colorbar if requested
if color_bar == 'T'
    colorbar;
end

% Show or hide axis ticks
if show_ticks == 'F'
    set(gca, 'XTick', [], 'YTick', []);
end
end