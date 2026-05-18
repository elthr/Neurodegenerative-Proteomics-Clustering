%% 06_cluster_validation.m
% Cluster validation and robustness

%% Compare clustering methods

all_results = {groups_k2, groups_sc_2, groups_sc_4};
names = {'k-means k=2','spectral k=2','spectral k=4'};

ch = zeros(1,3);
db = zeros(1,3);

for i = 1:3
    evaCH = evalclusters(data, all_results{i}, 'CalinskiHarabasz');
    evaDB = evalclusters(data, all_results{i}, 'DaviesBouldin');

    ch(i) = evaCH.CriterionValues;
    db(i) = evaDB.CriterionValues;
end

validation_table = table(names', ch', db', ...
    'VariableNames', {'Method','CalinskiHarabasz','DaviesBouldin'});

writetable(validation_table, '../results/tables/validation_metrics.csv');

%% Bootstrap stability

nBoot = 100;
nPatients = size(data,1);

ari_results = zeros(nBoot,3);

for b = 1:nBoot

    idx = randsample(nPatients, nPatients, true);

    bootData = data(idx,:);

    g1 = k_means(bootData, 2, 2);
    g2 = spectral_clustering(bootData, 2);
    g3 = spectral_clustering(bootData, 4);

    ari_results(b,1) = calc_ari(groups_k2(idx), g1);
    ari_results(b,2) = calc_ari(groups_sc_2(idx), g2);
    ari_results(b,3) = calc_ari(groups_sc_4(idx), g3);

end

stability = mean(ari_results);

save('../results/stability.mat','stability');
