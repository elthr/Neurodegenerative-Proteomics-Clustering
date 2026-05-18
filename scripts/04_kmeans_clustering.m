%% 04_kmeans_clustering.m
% k-means clustering analysis

%% k-means clustering (k=2 and k=7)

[groups_k2, ~, C_k2, ~, s_k2] = k_means(data, 2, 15);
[groups_k7, ~, C_k7, ~, s_k7] = k_means(data, 7, 15);

metadata_patient_classification.kmeans_2 = groups_k2;
metadata_patient_classification.kmeans_7 = groups_k7;

%% Cluster sizes

count_k2 = groupcounts(groups_k2);
count_k7 = groupcounts(groups_k7);

%% Crosstab with diagnosis

ct_k2 = crosstab(groups_k2, metadata_patient_classification.final_group_kth);
ct_k7 = crosstab(groups_k7, metadata_patient_classification.final_group_kth);

%% PCA projection for visualization

[coeff, score] = pca(data);

centroids_k2 = C_k2 * coeff(:,1:2);
centroids_k7 = C_k7 * coeff(:,1:2);

colors = lines(7);

%% Plot k=2

figure;
gscatter(score(:,1), score(:,2), groups_k2, colors(1:2,:));
hold on;
scatter(centroids_k2(:,1), centroids_k2(:,2), 120, 'k', 'd', 'filled');

title('k-means (k=2)');
box on;

saveas(gcf, '../results/figures/kmeans_k2.png');

%% Plot k=7

figure;
gscatter(score(:,1), score(:,2), groups_k7, colors);
hold on;
scatter(centroids_k7(:,1), centroids_k7(:,2), 120, 'k', 'd', 'filled');

title('k-means (k=7)');
box on;

saveas(gcf, '../results/figures/kmeans_k7.png');
