function [ domainEndPoints ] = findDomains( mat, windowWidth )
%findDomains Identify domains in an input matrix.
%   Uses a simple edge detection method to identify domains. If
%   windowWidth not specified, defaults to 5.
if nargin == 0
    error('findDomains: Not enough arguments, must give input matrix');
elseif nargin == 1
    windowWidth = 5;
end

% Start at top left corner
domainEndPoints=[];
curLocx=1;
curLocy=1;
while curLocx < length(mat) - windowWidth
   % From where you are, look at the local window and decide if you are at
   % a cliff or not.
   % The window to analyse is a rectangle with it's upper left corner
   % defined by curLocx and curLocy, it's bottom left corner defined by a
   % vertical line drawn straight down from the upper left corner to the
   % diagonal of the matrix. The width of the rectangle is windowWidth.
   windowHeight = curLocx - curLocy;    
   % Extract left and right half submatrices of the window.
   halfWidth = round(windowWidth/2);
   middlex = curLocx + halfWidth;
   %leftWindow = mat(curLocy:curLocy+windowHeight, curLocx:middlex);
   rightWindow = mat(curLocy:curLocy+windowHeight, middlex+1:curLocx+windowWidth);
   %leftSum = sum(sum(leftWindow));
   rightSum = sum(sum(rightWindow));
   if rightSum < windowHeight
       % We are near a cliff, should drop down back to the diagonal
       curLocx = curLocx + 1;
       curLocy = curLocx;
       % Write out the domain edge
       domainEndPoints = [domainEndPoints curLocx];
   else
       % Not near a cliff, keep going horizontally
       curLocx = curLocx + 1;
   end
   
end
domainEndPoints = [domainEndPoints length(mat)];
% Draw domains on the image
figure()
imshow(mat)
hold on
leftBoundary = 1;
for j = domainEndPoints(1:end)
    line([leftBoundary, j], [leftBoundary, leftBoundary], 'Color',...
        'r', 'LineWidth', 2)
    line([j, j], [leftBoundary, j], 'Color', 'r', 'LineWidth', 2)
    leftBoundary = j;
end
hold off
end
