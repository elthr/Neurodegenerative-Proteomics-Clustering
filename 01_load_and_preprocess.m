%% 01_load_and_preprocess.m
% Neurodegenerative Disease Clustering Project
% --------------------------------------------
% This script:
% 1. Loads raw proteomics and metadata tables
% 2. Sorts patients by numeric ID
% 3. Selects diagnostic groups
% 4. Harmonises ALS-related diagnoses
% 5. Preprocesses proteomics data
%    - log2 transformation
%    - z-score normalisation
% 6. Saves processed dataset

clearvars;
clc;

%% Reproducibility

rng(42);

%% Load data

% Adjust filenames if necessary
data_table_original = readtable('../data/raw/data_table_original.csv');
metadata_table = readtable('../data/raw/metadata_table.csv');

%% Sort tables by numeric patient ID

nums_d = cellfun(@(s) str2double(regexp(s,'(\d+)$','match','once')), ...
    data_table_original.id);

[~, idx_d] = sort(nums_d);

data_table_original = data_table_original(idx_d,:);

nums_m = cellfun(@(s) str2double(regexp(s,'(\d+)$','match','once')), ...
    metadata_table.id);

[~, idx_m] = sort(nums_m);

metadata_table = metadata_table(idx_m,:);

%% Select diagnostic groups

patient_selection = ...
       metadata_table.final_group_kth == "AD" ...
    |  metadata_table.final_group_kth == "ALS+PPA" ...
    |  metadata_table.final_group_kth == "ALS+bvFTD" ...
    |  metadata_table.final_group_kth == "MND" ...
    |  metadata_table.final_group_kth == "bvFTD" ...
    |  metadata_table.final_group_kth == "CBS" ...
    |  metadata_table.final_group_kth == "PPA" ...
    |  metadata_table.final_group_kth == "PSP" ...
    |  metadata_table.final_group_kth == "Healthy control";

patient_IDs = metadata_table.id(patient_selection);

%% Match selected patients to proteomics table

[~, loc] = ismember(patient_IDs, data_table_original.id);

data_table = data_table_original(loc(loc > 0), :);

%% Extract protein matrix

data = table2array(data_table(:, 2:end));

%% Match metadata to selected patients

[~, loc_m] = ismember(data_table.id, metadata_table.id);

metadata_table_final = metadata_table(loc_m, :);

%% Harmonise ALS-related groups

metadata_table_final.final_group_kth( ...
    strcmp(metadata_table_final.final_group_kth, 'ALS+PPA') | ...
    strcmp(metadata_table_final.final_group_kth, 'ALS+bvFTD') | ...
    strcmp(metadata_table_final.final_group_kth, 'MND') ) = {'ALS'};

%% Convert age to numeric

ages = string(metadata_table_final.age_sampling_kth);

metadata_table_final.age_sampling_kth = str2double(ages);

%% Create classification table

metadata_patient_classification = ...
    metadata_table_final(:, ...
    {'id','final_group_kth','gender','age_sampling_kth'});

metadata_patient_classification.final_group_kth = ...
    categorical(metadata_patient_classification.final_group_kth);

metadata_patient_classification.gender = ...
    categorical(metadata_patient_classification.gender);

%% Log2 transformation

data = log2(data);

%% Z-score normalisation

data = zscore(data);

%% Save processed data

save('../data/processed/preprocessed_data.mat', ...
    'data', ...
    'data_table', ...
    'metadata_table_final', ...
    'metadata_patient_classification');

disp('Preprocessing complete.');
