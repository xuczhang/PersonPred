%data_file = strcat('~/Dataset/PersonPred/synthetic.mat');
data_file = strcat('D:/Dataset/PersonPred/synthetic.mat');
data = load(data_file);
Xtr = data.Xtr;
Ytr_arr = data.Ytr_arr;

Xte = data.Xte;
Yte_arr = data.Yte_arr;

Beta_truth_arr = data.Beta_arr;

tic;
[Beta_arr, S_arr] = Baseline_RLHH(Xtr, Ytr_arr);
toc;

obj_num = size(Ytr_arr, 2);

total_error = 0;
for i = 1:obj_num
    beta_pred = Beta_arr{i};
    S = S_arr{i};
    beta_truth = Beta_truth_arr{i};
    error = norm(beta_truth-beta_pred);
    fprintf('[%d] %f %d\n', i, error, size(S,1));
    total_error = total_error + error;
end

fprintf('Total error: %f\n', total_error);