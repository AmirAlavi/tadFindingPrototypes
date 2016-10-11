function [ ] = plotBoundaries( mat, boundaries, boundaryHeight, plotTitle )
%plotBoundaries Draw the boundaries from idea2 on the matrix image to see
% if they provide any useful information

figure()
imshow(mat)
hold on
line([0, length(mat)], [0, length(mat)], 'Color',...
        [1, 0.5 0], 'LineWidth', 1)
for j = 1:length(boundaries)
    boundary = boundaries{j};
    boundaryX = boundary(1);
    boundaryY = boundary(2);
    % Draw vertical line
    line([boundaryX, boundaryX], [boundaryY, (boundaryY+boundaryHeight)], 'Color', 'r', 'LineWidth', 1)
end
hold off
title(plotTitle)
axis on
end

