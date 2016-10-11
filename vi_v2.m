function out = vi_v2(x1,x2,chrlength)

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
% x1clus(x1clus == 0) = clusnum;

x2clus = ones(chrlength,1);
clusnum = 2;
for i = 1:length(x2)
    x2clus(x2(i,1):x2(i,2)) = clusnum;
    clusnum = clusnum + 1;
end
% x2clus(x2clus == 0) = clusnum;

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
if length(x1_unique) > length(x1)
    A = zeros(length(x1_unique),chrlength);
else
    A = zeros(length(x1_unique)+1,chrlength);
end
for i = 1:length(x1)
    A(i+1, x1(i,1):x1(i,2)) = 1;
end
A(1, sum(A) == 0) = 1;

if sum(sum(A) > 1) ~= 0
    overlaps_i = find(sum(A) > 1);
    for i = 1:length(overlaps_i)
        overlapcol = overlaps_i(i);
        overlaps_j = find(A(:,overlapcol) == 1);
        A(overlaps_j(1:end-1),overlapcol) = 0;
    end
end

% if sum(A) == ones(size(sum(A)))
%     fprintf('yay A \n')
% else
%     fprintf('damn it A \n')
% end

% testA = A;
% for i=1:size(A,1)
%     testA(i,:) = i*A(i,:);
% end
% testA = sum(testA)';
% 
% if sum(x1clus ~= testA) > 0
%     fprintf('well shit\n')
% end

if length(x2_unique) > length(x2)
    B = zeros(chrlength,length(x2_unique));
else
    B = zeros(chrlength,length(x2_unique)+1);
end
for i = 1:length(x2)
    B(x2(i,1):x2(i,2),i+1) = 1;
end
B(sum(B,2) == 0, 1) = 1;

if sum((sum(B,2) > 1)) ~= 0
    overlaps_i = find(sum(B,2) > 1);
%     fprintf(strcat('B overlaps: ',num2str(overlaps_i)))
    for i = 1:length(overlaps_i)
        overlaprow = overlaps_i(i);
        overlaps_j = find(B(overlaprow,:) == 1);
        B(overlaprow, overlaps_j(1:end-1)) = 0;
    end
end

% if sum(B,2) == ones(size(sum(B,2)))
%     fprintf('yay B \n')
% else
%     fprintf('damn it B \n')
% end

% testB = B;
% for i=1:size(B,2)
%     testB(:,i) = i*B(:,i);
% end
% testB = sum(testB,2);
% 
% if sum(x2clus ~= testB) > 0
%     fprintf('well shit\n')
% end

A(sum(A,2)==0,:) = [];
B(:,sum(B)==0) = [];

C = (1/N)*(A*B);
% C = A*B;

mutinfo2 = 0;
for i = 1:length(x1_unique)
    for j = 1:length(x2_unique)
        pxiyj = C(i,j);
%         pxiyj2 = sum((x1clus == x1_unique(i)).*(x2clus == x2_unique(j)));
%         if pxiyj ~= pxiyj2
%             fprintf(strcat(num2str(pxiyj - pxiyj2),'\n'))
%         end
%         pxiyj = pxiyj/N;
%         pxiyj2 = pxiyj2/N;
        if pxiyj > 0
            mutinfo = mutinfo + pxiyj*log(pxiyj/(px1(i)*px2(j)));
        end
%         if pxiyj2 > 0
%             mutinfo2 = mutinfo2 + pxiyj2*log(pxiyj2/(px1(i)*px2(j)));
%         end
    end
end

% fprintf(strcat('orig method mutinfo =',num2str(mutinfo2),'\n'))
% fprintf(strcat('new method mutinfo =',num2str(mutinfo),'\n'))

% final VI calculation
out = entropy_x1 + entropy_x2 - 2*mutinfo;