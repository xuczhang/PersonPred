%data_file = strcat('~/Dataset/PersonPred/synthetic.mat');

p = 100; % feature dimension
k = 10;
cr = 0.5;
bNoise = 1;
obj_num = 5;
idx = 1;

%data_file = strcat('D:/Dataset/PersonPred/synthetic.mat');
data_file = FindDataPath( p, k, cr, bNoise, obj_num, idx );
data = load(data_file);
Xtr = data.Xtr;
Ytr_arr = data.Ytr_arr;

Xte = data.Xte;
Yte_arr = data.Yte_arr;

Beta_truth_arr = data.Beta_arr;

tic;
[Beta_arr, S] = PersonPred(Xtr, Ytr_arr);
toc;

obj_num = size(Ytr_arr, 2);
total_error = 0;
for i = 1:obj_num
    beta_pred = Beta_arr{i};
    beta_truth = Beta_truth_arr{i};
    error = norm(beta_truth-beta_pred);
    fprintf('[%d] %f %d\n', i, error, size(S,1));
    total_error = total_error + error;
end

fprintf('Total error: %f\n', total_error);