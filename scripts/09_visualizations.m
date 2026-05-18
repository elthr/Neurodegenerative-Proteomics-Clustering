%% 09_visualizations.m
% Final publication-ready visualizations

%% Load results if needed

% Uncomment if running standalone
% load('../data/processed/preprocessed_data.mat');

%% Set consistent figure style

set(groot, 'DefaultAxesFontSize', 12);
set(groot, 'DefaultLineLineWidth', 1.2);

%% PCA final plot (if available in workspace)

if exist('score','var') && exist('groups_k2','var')

    figure;
    gscatter(score(:,1), score(:,2), groups_k2);

    xlabel('PC1');
    ylabel('PC2');
    title('Final PCA - k-means (k=2)');
    box on;

    saveas(gcf, '../results/figures/final_pca_k2.png');

end

%% Cluster agreement visualization

if exist('groups_k2','var') && exist('groups_sc_2','var')

    diff_idx = groups_k2 ~= groups_sc_2;

    figure;
    hold on;

    gscatter(score(:,1), score(:,2), groups_k2);
    scatter(score(diff_idx,1), score(diff_idx,2), ...
        40, 'k', 'filled');

    title('Clustering disagreement (k-means vs spectral)');
    legend('Cluster 1','Cluster 2','Mismatch');

    box on;

    saveas(gcf, '../results/figures/cluster_disagreement.png');

end

%% Save session summary

results_summary = struct();
results_summary.timestamp = datetime;
results_summary.note = "Final visualization script executed";

save('../results/results_summary.mat', 'results_summary');

disp('Visualization pipeline completed.');
