% Author: Natalie Sauerwald
function out = vi(x1,x2,chrlength)

% calculate variation of information for two clustering schemes x1, x2
% x1 and x2 are armatus outputs - 2 columns representing start and ends of
% domains (not yet adjusted for resolution)
% chrlength - just number of rows of raw data matrix
% res - 2 element vector with resolutions for x1 and x2

% x1 and x2 need to be converted to vectors of length of chromosome, with numbers corresponding
% to clusters for each index

% x1 = x1/res(1);
% x2 = x2/res(2);

if x1(end,1) == 0
    x1(end,1) = 1;
elseif x1(1,1) == 0
    x1(1,1) = 1;
end
if x2(end,1) == 0
    x2(end,1) = 1;
elseif x2(1,1) == 0
    x2(1,1) = 1;
end

% create new vector x1clus in proper format
x1clus = ones(chrlength,1);
clusnum = 2;
for i = 1:length(x1)
    x1clus(x1(i,1):x1(i,2)) = clusnum;
    clusnum = clusnum + 1;
end

x2clus = ones(chrlength,1);
clusnum = 2;
for i = 1:length(x2)
    x2clus(x2(i,1):x2(i,2)) = clusnum;
    clusnum = clusnum + 1;
end

% start actual VI calculation
% first calculate entropy for x1clus and x2clus
% entropy = - sum_i(prob(xi)*log(prob(xi)))

x1_unique = unique(x1clus);
N = length(x1clus);

px1 = histc(x1clus, x1_unique)/N;
entropy_x1 = -sum(px1.*log(px1));

x2_unique = unique(x2clus);
px2 = histc(x2clus, x2_unique)/N;
entropy_x2 = -sum(px2.*log(px2));

% calculate mutual information
% mutualinfo(x,y) = sum_i sum_j
%            (prob(xi,yj)*log(prob(xi,yi)/(prob(xi)*prob(yj))))

mutinfo = 0;

for i = 1:length(x1_unique)
    for j = 1:length(x2_unique)
        pxiyj = sum((x1clus == x1_unique(i)).*(x2clus == x2_unique(j)))/N;
        if pxiyj > 0
            mutinfo = mutinfo + pxiyj*log(pxiyj/(px1(i)*px2(j)));
        end
    end
end

% final VI calculation
out = entropy_x1 + entropy_x2 - 2*mutinfo;