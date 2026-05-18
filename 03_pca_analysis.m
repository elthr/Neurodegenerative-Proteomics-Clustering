%% 03_pca_analysis.m
% PCA analysis of proteomics data

%% PCA

[coeff, score, ~, ~, explained] = pca(data);

PCA_2_explained = sum(explained(1:2));

groups = categorical(metadata_patient_classification.final_group_kth);

%% Basic PCA plot

figure;
gscatter(score(:,1), score(:,2));
xlabel('PC1'); ylabel('PC2');
title('PCA - Uncolored');
box on;

saveas(gcf, '../results/figures/pca_uncolored.png');

%% PCA colored by disease group

colors = [
    0.85 0.33 0.10;
    0.47 0.67 0.19;
    0.49 0.18 0.56;
    0.93 0.69 0.13;
    0.64 0.08 0.18;
    1 0 1;
    0.30 0.30 0.30;
];

figure;
gscatter(score(:,1), score(:,2), groups, colors);

xlabel('PC1'); ylabel('PC2');
title('PCA - Disease groups');
legend(categories(groups), 'Location','northeast');

box on;

saveas(gcf, '../results/figures/pca_disease_groups.png');
