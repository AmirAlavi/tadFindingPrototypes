% Driving script (uncomment lines depending on what you want to test)

% Run on Dixon data
chr01 = load('DixonChr01HiC.mat');
chr01domains = findDomains(chr01.data);
%plotDomainSet(chr01.data, domains, 'Chromosome 01');

chr22 = load('DixonChr22HiC.mat');
domains = findDomains(chr22.data);
%plotDomainSet(chr22.data, domains, 'Chromosome 22');

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
calcDomainStats(chr01domains)
calcDomainStats(armatusChr01Domains)

% boundaries = idea3(chr01.data);
% boundariesToCoordinates(boundaries);

% VI:
%vi2(
[baselineVI, VIs] = getBaselineVI(chr01domains, dixonChr01Domains, length(chr01.data));
VI = vi_v2(chr01domains, dixonChr01Domains, length(chr01.data));
if VI > baselineVI
    pVal = sum(VIs > VI) / length(VIs);
else
    pVal = sum(VIs < VI) / length(VIs);
end
pVal = pVal * 2;
