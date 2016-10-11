function [ ] = calcDomainStats( domains )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 % Calculate average domain size
domainSizes = zeros([1, length(domains)]);
for i = 1:length(domains)
    domain = domains(i,:);
    size = domain(2) - domain(1);
    domainSizes(i) = size;
end
avgSize = mean(domainSizes);
fprintf('Average domain size: %f\n', avgSize)
end

