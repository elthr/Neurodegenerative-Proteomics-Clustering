%% 08_protein_modules.m
% Protein correlation networks and module structure

%% Correlation matrix

C = corr(data);

figure;
imagesc(C);
colorbar;
axis square;
title('Protein correlation matrix');

saveas(gcf, '../results/figures/correlation_matrix.png');

%% Convert correlation to distance

D = 1 - C;

%% Hierarchical clustering

Z = linkage(D, 'average');

figure;
dendrogram(Z, 0);

title('Protein dendrogram (1 - correlation)');
ylabel('Dissimilarity');

set(gca, 'XTick', []);

saveas(gcf, '../results/figures/protein_dendrogram.png');

%% Optional: reorder correlation matrix by clustering

[~, ~, perm] = dendrogram(Z, 0);

figure;
imagesc(C(perm, perm));
colorbar;
axis square;

title('Clustered correlation matrix');

saveas(gcf, '../results/figures/correlation_matrix_clustered.png');
