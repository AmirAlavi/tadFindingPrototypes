function [ ] = plotDomains( mat, domains, plotTitle )
%plotDomains Draw the domains on an image of the input matrix.

figure()
imshow(mat)
hold on
for j = 1:length(domains)
    domain = domains{j};
    dStart = domain(1);
    dEnd = domain(2);
    % Draw the horizontal side
    line([dStart, dEnd], [dStart, dStart], 'Color',...
        'r', 'LineWidth', 2)
    % Draw the vertical side
    line([dEnd, dEnd], [dStart, dEnd], 'Color', 'r', 'LineWidth', 2)
end
hold off
title(plotTitle)
end

