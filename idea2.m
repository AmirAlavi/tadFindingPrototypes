function [ boundaries ] = idea2( mat )
%findDomains Identify domains in an input matrix.

minDens = 0.0;
tolerance = 0.4;
windowWidth = 5;
windowHeight = 5;
halfWidth = round(windowWidth/2);

% Start at top left corner
curLocx = 1;
curLocy = 1;

boundaries = {};
boundariesIdx = 1;

while curLocy < length(mat) - windowHeight
   % From where you are, look at the local window and decide if you are at
   % a cliff or not.
   % The window to analyse is a rectangle with its upper left corner
   % defined by curLocx and curLocy, its bottom left corner defined by a
   % vertical line drawn straight down from the upper left corner to the
   % diagonal of the matrix. The width of the rectangle is windowWidth.
   
   % Extract left and right half submatrices of the window.
   curLocx = curLocy;
   while curLocx < length(mat) - windowWidth;
       
       middlex = curLocx + halfWidth;
       leftWindow = mat(curLocy:curLocy+windowHeight, curLocx:middlex);
       rightWindow = mat(curLocy:curLocy+windowHeight, middlex+1:curLocx+windowWidth);
       % Calculate the density of the left and right windows
       lDens = nnz(leftWindow)/numel(leftWindow);
       rDens = nnz(rightWindow)/numel(rightWindow);
       if lDens - rDens > tolerance
           boundaries{boundariesIdx} = [middlex curLocy];
           boundariesIdx = boundariesIdx + 1;
       end
       curLocx = curLocx + 1;
   end
   curLocy = curLocy + windowHeight;
   fprintf('Cur y loc: %d\n', curLocy)
end
end

