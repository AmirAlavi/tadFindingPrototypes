% (Inspired by code by Natalie Sauerwald)
function [ baselineVI  VIs] = getBaselineVI( domains1, domains2, chrLength )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Possible issue: some domain sets might double count the end of a domain
% as the start of the other domain, while others never do this.

% Capture the length of any gaps between domains that are significantly
% large as "pseudo-domains" (to spread out the gaps in the random
% shufflings)
significantGapSize = 2;

% Get a list of all the lengths to be randomly shuffled
lengths = [];
curLoc = 1;
for k = 1:length(domains2)
    dStart = domains2(k,1);
    dEnd = domains2(k,2);
    offset = dStart - curLoc;
    if offset > significantGapSize
        lengths = [lengths offset];
    end
    lengths = [lengths (dEnd-dStart)];
    curLoc = dEnd;
end
tailEnd = chrLength - curLoc;
if tailEnd > significantGapSize
    lengths = [lengths tailEnd];
end

% Shuffle and calculate VI 500 times
VIs = [];
for i = 1:1000
    randIndices = randperm(length(lengths));
    shuffledLengths = lengths(randIndices);
    shuffledDoms = [];
    curStart = 1;
    for j = shuffledLengths
        curEnd = curStart + j;
        newDom = [curStart curEnd];
        shuffledDoms = [shuffledDoms; newDom];
        curStart = curEnd;
    end
    VIs = [VIs vi_v2(domains1, shuffledDoms, chrLength)];
end
baselineVI = mean(VIs);
figure()
histogram(VIs)
fprintf('Baseline VI is: %f\n', baselineVI)
end

