function [ mat ] = getBinaryMat( roughSize )
%getBinaryMat Get simulated data for TAD finding.
%   Returns random, binary, block-diagonal matrix, about
%   roughSize x roughSize.
%   If roughSize not specified, defaults to 1000.
if nargin == 0
   roughSize = 1000; 
end

sizeSoFar = 0;
blocks = {};
blockIdx = 1;
% Each iteration, generate a random number to be the size of a block in
% the matrix. Keep track of the total size of the blocks created so far,
% and limit the size of each new block generated to be less than half of
% the remaining size.
% It's called a "roughSize" because we will never make blocks smaller than
% 10, and this constraint could make the matrix slightly larger than the
% specified size.
while sizeSoFar < roughSize
    blockSize = randi(round((roughSize - sizeSoFar)/2)) + 10;
    block = ones(blockSize);
    blocks{1, blockIdx} = block;
    sizeSoFar = sizeSoFar + blockSize;
    blockIdx = blockIdx + 1;
end
shuffledBlocks = blocks(randperm(length(blocks)));

mat = [];
for i = 1:length(shuffledBlocks)
    mat = blkdiag(mat, shuffledBlocks{i});
end
end

