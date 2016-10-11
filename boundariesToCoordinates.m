function [ output_args ] = boundariesToCoordinates( boundaries )
%boundariesToCoordinates Map the boundary data from idea2 onto a coordinate
% space to see if clustering is a possibility.
figure()
scatter(boundaries(:,1), boundaries(:,2))
end

