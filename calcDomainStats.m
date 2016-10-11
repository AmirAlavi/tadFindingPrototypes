function [ ] = calcDomainStats( domains )
%calcDomainStats Calculate various statistics on the domains.

% For now we just calculate mean and stddev of domain sizes
domainSizes = zeros([1, length(domains)]);
for i = 1:length(domains)
    domain = domains(i,:);
    size = domain(2) - domain(1);
    domainSizes(i) = size;
end
avgSize = mean(domainSizes);
stddev = std(domainSizes);
fprintf('Average domain size: %f, Standard deviation: %f\n', avgSize,...
    stddev)
end

