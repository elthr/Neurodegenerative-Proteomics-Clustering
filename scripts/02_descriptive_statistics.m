%% 02_descriptive_statistics.m
% Descriptive statistics of cohort

%% Group sizes

group_sizes = groupcounts(metadata_table_final, "final_group_kth");

%% Overall gender distribution

female_count = sum(metadata_table_final.gender == 'F');
total_count = height(metadata_table_final);
female_percent = 100 * female_count / total_count;

gender_distribution = table(female_count, female_percent);

%% Gender per group

groups = unique(metadata_table_final.final_group_kth);

female_count = zeros(numel(groups),1);
total_count = zeros(numel(groups),1);

for i = 1:numel(groups)
    idx = metadata_table_final.final_group_kth == groups(i);

    total_count(i) = sum(idx);
    female_count(i) = sum(metadata_table_final.gender(idx) == 'F');
end

result_females_per_group = table(groups, female_count, total_count, ...
    100*female_count./total_count, ...
    'VariableNames', {'Group','Female_Count','Total','Female_Percent'});

%% Age statistics per group

median_age = zeros(numel(groups),1);
min_age = zeros(numel(groups),1);
max_age = zeros(numel(groups),1);

for i = 1:numel(groups)
    idx = metadata_table_final.final_group_kth == groups(i);
    ages = metadata_table_final.age_sampling_kth(idx);

    median_age(i) = median(ages,'omitnan');
    min_age(i) = min(ages);
    max_age(i) = max(ages);
end

result_age = table(groups, median_age, min_age, max_age, ...
    'VariableNames', {'Group','Median_Age','Min_Age','Max_Age'});

%% Save results

writetable(result_females_per_group, '../results/tables/gender_by_group.csv');
writetable(result_age, '../results/tables/age_by_group.csv');
