function [L, D, W] = laplacian(X, kNN)
% Constructs normalized graph Laplacian for spectral clustering

n = size(X,1);

%% Distance matrix
distMat = squareform(pdist(X, 'euclidean'));

%% Gaussian kernel width
sigma = median(distMat(:));

%% kNN similarity graph
W = zeros(n,n);

for i = 1:n
    [~, idx] = sort(distMat(i,:));
    neighbors = idx(2:kNN+1); % exclude self

    for j = neighbors
        W(i,j) = exp(-(distMat(i,j)^2) / (2*sigma^2));
    end
end

%% Symmetrize graph
W = max(W, W');

%% Degree matrix
D = diag(sum(W,2));

%% Normalized Laplacian
D_inv_sqrt = diag(1 ./ sqrt(diag(D) + eps));

L = D_inv_sqrt * (D - W) * D_inv_sqrt;
end
