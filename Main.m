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
chr01 = load('DixonChr01HiC.mat');
chr01domains = findDomains(chr01.data);
plotDomainSet(chr01.data, domains, 'Chromosome 01');

chr22 = load('DixonChr22HiC.mat');
domains = findDomains(chr22.data);
plotDomainSet(chr22.data, domains, 'Chromosome 22');

% Load Armatus results
armatusChr01 = load('ArmatusChr01Gamma0_5.mat');
armatusChr01Domains = armatusChr01.data;
plotTwoDomainSets(chr01.data, chr01domains, 'New method',...
    armatusChr01Domains, 'Armatus (gamma= 0.5)',...
    'Chromosome 01, Compared to Armatus')
calcDomainStats(chr01domains)
calcDomainStats(armatusChr01Domains)

