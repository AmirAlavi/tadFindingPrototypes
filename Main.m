% Driving script (uncomment lines depending on what you want to test)

% % Create the simulated-data matrix
% mat = getBinaryMat();
% 
% % Add noise
% % mat = imnoise(mat, 'salt & pepper', 0.6);
% mat = imnoise(mat, 'gaussian', 0.5, 0.5);
% 
% % Run on simulated data
% domains = findDomains(mat);
% plotDomains(mat, domains);

% Run on Dixon data
chr01 = load('DixonChr01.mat');
domains = findDomains(chr01.data);
plotDomains(chr01.data, domains, 'Chromosome 01');

chr22 = load('DixonChr22.mat');
domains = findDomains(chr22.data);
plotDomains(chr22.data, domains, 'Chromosome 22');
