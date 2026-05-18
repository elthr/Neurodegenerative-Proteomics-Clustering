clear; clc; close all;

run('scripts/01_load_and_preprocess.m')
run('scripts/02_descriptive_statistics.m')
run('scripts/03_pca_analysis.m')
run('scripts/04_kmeans_clustering.m')
run('scripts/05_spectral_clustering.m')
run('scripts/06_cluster_validation.m')
run('scripts/07_biological_analysis.m')
run('scripts/08_protein_modules.m')
run('scripts/09_visualizations.m');
