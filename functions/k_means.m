function [groups, k, C, error, s_value] = k_means(X, a, b)
% K-means clustering with k selection via silhouette score
% Uses k-means++ initialization

%% Optimal k via silhouette
eva = evalclusters(X, 'kmeans', 'silhouette', 'KList', a:b);

k = eva.OptimalK;
s_value = eva.CriterionValues;

%% Final clustering
[groups, C, sumd] = kmeans( ...
    X, k, ...
    'Start', 'plus', ...
    'Replicates', 50);

error = sum(sumd);
end
