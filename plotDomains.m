function [ ] = plotDomains( domains , color)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for j = 1:length(domains)
    domain = domains(j,:);
    dStart = domain(1);
    dEnd = domain(2);
    % Draw the horizontal side
    line([dStart, dEnd], [dStart, dStart], 'Color',...
        color, 'LineWidth', 1)
    % Draw the vertical side
    line([dEnd, dEnd], [dStart, dEnd], 'Color', color, 'LineWidth', 1)
end
end

