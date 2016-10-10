function [ ] = plotDomainSet( mat, domains, plotTitle )
%plotDomainSet Draw the domains on an image of the input matrix.

figure()
imshow(mat)
hold on
line([0, length(mat)], [0, length(mat)], 'Color',...
        [1, 0.5 0], 'LineWidth', 1)
plotDomains(domains, 'r');
hold off
title(plotTitle)
axis on
end

