function [ ] = plotTwoDomainSets( mat, domains1, d1name, domains2, d2name, plotTitle )
%plotDomains Draw the domains on an image of the input matrix.

figure()
imshow(mat)
hold on
line([0, length(mat)], [0, length(mat)], 'Color',...
        [1, 0.5 0], 'LineWidth', 1)
plotDomains(domains1, 'r');
plotDomains(domains2, 'b');
hold off
title(plotTitle)
a1 = annotation('textbox', [0.7, 0.85 ,0.1,0.1],...
           'String', d1name);
a1.BackgroundColor = 'w';
a1.Color = 'r';
a2 = annotation('textbox', [0.7, 0.8 ,0.1,0.1],...
           'String', d2name);
a2.BackgroundColor = 'w';
a2.Color = 'b';
axis on
end

