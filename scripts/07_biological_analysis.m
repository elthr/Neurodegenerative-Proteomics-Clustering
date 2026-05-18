%% 07_biological_analysis.m
% Biological interpretation of clusters

%% Protein differences (k-means k=2)

protein_names = data_table.Properties.VariableNames(2:end);
nProteins = size(data,2);

diff = zeros(1,nProteins);
cohens_d = zeros(1,nProteins);
pvals = zeros(1,nProteins);

for j = 1:nProteins

    x1 = data(groups_k2==1, j);
    x2 = data(groups_k2==2, j);

    diff(j) = mean(x2) - mean(x1);

    s1 = std(x1);
    s2 = std(x2);
    sp = sqrt(((numel(x1)-1)*s1^2 + (numel(x2)-1)*s2^2) / ...
        (numel(x1)+numel(x2)-2));

    cohens_d(j) = diff(j) / sp;

    pvals(j) = ranksum(x1, x2);

end

p_adj = mafdr(pvals, 'BHFDR', true);

results = table(protein_names(:), diff(:), cohens_d(:), pvals(:), p_adj(:), ...
    'VariableNames', {'Protein','Diff','Cohens_d','pval','p_adj'});

results = sortrows(results,'Diff','descend');

writetable(results, '../results/tables/protein_analysis_k2.csv');
