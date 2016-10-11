% Driving script (uncomment lines depending on what you want to test)

% Create the simulated-data matrix
mat = getBinaryMat();
domains = findDomains(mat);
plotDomainSet(mat, domains, 'Trivial Data');

% Add noise
% mat = imnoise(mat, 'salt & pepper', 0.6);
mat = round(imnoise(mat, 'gaussian', 0.5, 0.5));

% Run on simulated data
domains = findDomains(mat, 0.25);
plotDomainSet(mat, domains, 'Simualated Noisy Data');

% Run on Dixon data
chr01 = load('DixonChr01HiC.mat');
chr01domains = findDomains(chr01.data);
plotDomainSet(chr01.data, chr01domains, 'Chromosome 01');

chr22 = load('DixonChr22HiC.mat');
chr22domains = findDomains(chr22.data);
plotDomainSet(chr22.data, chr22domains, 'Chromosome 22');

% Load Armatus results
armatusChr01 = load('ArmatusChr01Gamma0_5.mat');
armatusChr01Domains = armatusChr01.domains;
plotTwoDomainSets(chr01.data, chr01domains, 'New method',...
    armatusChr01Domains, 'Armatus (gamma= 0.5)',...
    'Chromosome 01, Compared to Armatus')

% Load Dixon results
dixonChr01 = load('DixonChr01Domains.mat');
dixonChr01Domains = dixonChr01.domains;
plotTwoDomainSets(chr01.data, chr01domains, 'New method',...
    dixonChr01Domains, 'Dixon et al', 'Chromosome 01, Compared to Dixon');
xlim([1400 3000])
ylim([1400 3000])

calcDomainStats(chr01domains)
calcDomainStats(dixonChr01Domains)
calcDomainStats(armatusChr01Domains)

% VI:
[baselineVI, VIs] = getBaselineVI(chr01domains, dixonChr01Domains,...
    length(chr01.data));
VI = vi_v2(chr01domains, dixonChr01Domains, length(chr01.data));
hold on
line([VI, VI], [0, 8], 'Color', [1 0.5 0], 'LineWidth', 2)
hold off
