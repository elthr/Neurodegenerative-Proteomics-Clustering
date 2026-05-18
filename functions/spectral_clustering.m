function groups = spectral_clustering(U, k)
% Spectral clustering using k-means on normalized eigenvectors

%% Row-normalization
T = U ./ sqrt(sum(U.^2,2) + eps);

%% Final clustering
groups = kmeans( ...
    T, k, ...
    'Start','plus', ...
    'Replicates',50);
end
