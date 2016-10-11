function [ domains ] = findDomains( mat, tolerance, minDens, windowWidth )
%findDomains Identify domains in an input matrix.

% Fill in optional args w/defaults if not given
switch nargin
    case 1
        tolerance = 0.1;
        minDens = 0.0;
        windowWidth = 5;
    case 2
        minDens = 0.0;
        windowWidth = 5;
    case 3
        windowWidth = 5;
end

halfWidth = round(windowWidth/2);

% Start at top left corner
curLocx = 1;
curLocy = 1;

% List of domains we have found
domains = [];

onDomain = false;
curDomainStart = 0;

while curLocx < length(mat) - windowWidth
   % From where you are, look at the local window and decide if you are at
   % a cliff or not.
   % The window to analyse is a rectangle with its upper left corner
   % defined by curLocx and curLocy, its bottom left corner defined by a
   % vertical line drawn straight down from the upper left corner to the
   % diagonal of the matrix. The width of the rectangle is windowWidth.
   windowHeight = curLocx - curLocy;    
   % Extract left and right half submatrices of the window.
   middlex = curLocx + halfWidth;
   leftWindow = mat(curLocy:curLocy+windowHeight, curLocx:middlex);
   rightWindow = mat(curLocy:curLocy+windowHeight, middlex+1:curLocx+windowWidth);
   % Calculate the density of the left and right windows
   lDens = nnz(leftWindow)/numel(leftWindow);
   rDens = nnz(rightWindow)/numel(rightWindow);
   
   if ~onDomain && lDens > minDens
       % If not currently on a domain, but the left window's density is
       % above your minimum density, then begin a domain here.
       onDomain = true;
       curDomainStart = curLocx;
   end
   if onDomain
       if lDens - rDens > tolerance || lDens <= minDens
           % Detected an edge, end this domain
           newDomain = [curDomainStart middlex];
           domains = [domains; newDomain];
           onDomain = false;
           curLocx = curLocx + windowWidth;
           curLocy = curLocx;
       else
           % Still within a domain, keep moving forward
           curLocx = curLocx + 1;
       end
   else
       % not on a domain at all, keep moving down the diagonal
       curLocx = curLocx + 1;
       curLocy = curLocx;
   end
end

% Make sure to add the last domain to the list (if algorithm reached end
% of the matrix in the middle of a domain):
if onDomain
    lastDomain = [curDomainStart length(mat)];
    domains = [domains; lastDomain];
end
end

