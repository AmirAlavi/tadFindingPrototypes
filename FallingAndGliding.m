% "Gliding and Falling" domain finding prototype

% Create the matrix
mat = getBinaryMat();

% Add noise
% mat = imnoise(mat, 'salt & pepper', 0.6);
mat = imnoise(mat, 'gaussian', 0.5, 0.5);

domains = findDomains(mat);
