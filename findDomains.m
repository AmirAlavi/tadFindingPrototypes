function [ domains ] = findDomains( mat )
%findDomains Identify domains in an input matrix.

minDens = 0.0;
tolerance = 0.9;
windowWidth = 5;

% Start at top left corner
curLocx = 1;
curLocy = 1;

% List of domains we have found
domains = {};
domainsIdx = 1;

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
   halfWidth = round(windowWidth/2);
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
       if lDens - rDens > 1 - tolerance || lDens <= minDens
           % Detected an edge, end this domain
           onDomain = false;
           curLocx = curLocx + windowWidth;
           domains{domainsIdx} = [curDomainStart curLocx];
           domainsIdx = domainsIdx + 1;
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
    domains{domainsIdx} = [curDomainStart length(mat)];
end
end

