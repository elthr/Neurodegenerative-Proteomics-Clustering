%% 05_spectral_clustering.m
% Spectral clustering analysis

%% Parameters

kNN = 10;

%% Laplacian

[L, ~, W] = laplacian(data, kNN);

%% Eigen decomposition

[eigvecs, eigvals] = eig(L);
lambda = diag(eigvals);

[~, idx] = sort(lambda);
eigvecs = eigvecs(:, idx);

%% Eigengap inspection (optional plot)

figure;
plot(lambda(idx), '-o');
title('Eigenvalues (Laplacian)');
saveas(gcf, '../results/figures/eigenvalues.png');

%% Clustering

U2 = eigvecs(:,1:2);
U4 = eigvecs(:,1:4);
U7 = eigvecs(:,1:7);

groups_sc_2 = spectral_clustering(U2, 2);
groups_sc_4 = spectral_clustering(U4, 4);
groups_sc_7 = spectral_clustering(U7, 7);

metadata_patient_classification.spectral_2 = groups_sc_2;
metadata_patient_classification.spectral_4 = groups_sc_4;
metadata_patient_classification.spectral_7 = groups_sc_7;

%% Visualisation (PCA space)

[~, score] = pca(data);

colors = lines(7);

figure;
gscatter(score(:,1), score(:,2), groups_sc_2, colors(1:2,:));
title('Spectral clustering k=2');
saveas(gcf, '../results/figures/spectral_k2.png');

figure;
gscatter(score(:,1), score(:,2), groups_sc_4, colors);
title('Spectral clustering k=4');
saveas(gcf, '../results/figures/spectral_k4.png');

figure;
gscatter(score(:,1), score(:,2), groups_sc_7, colors);
title('Spectral clustering k=7');
saveas(gcf, '../results/figures/spectral_k7.png');
