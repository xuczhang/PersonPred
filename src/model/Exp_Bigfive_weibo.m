data_file = strcat('D:/Dataset/PersonPred/bigfive_weibo_liwc/bigfive_1000.mat');

data = load(data_file);
Xtr = data.Xtr;
Ytr_arr = data.Ytr_arr;

Xte = data.Xte;
Yte_arr = data.Yte_arr;

OLS_Beta_arr = Baseline_OLS(Xtr, Ytr_arr);
[OLS_pc, OLS_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, OLS_Beta_arr);
fprintf('=== OLS ===\n');
disp(OLS_pc);
% % 
OLSL_Beta_arr = Baseline_OLS_Lasso(Xtr, Ytr_arr);
[OLSL_pc, OLSL_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, OLSL_Beta_arr);
fprintf('=== OLSL ===\n');
disp(OLSL_pc);

[RLHH_Beta_arr, RLHH_S_arr] = Baseline_RLHH(Xtr, Ytr_arr);
[RLHH_pc, RLHH_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RLHH_Beta_arr);
fprintf('=== RLHH ===\n');
disp(RLHH_pc);


% [RLHH_Beta_arr, RLHH_S_arr] = Baseline_RLHH_Lasso(Xtr, Ytr_arr);
% [RLHH_pc, RLHH_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RLHH_Beta_arr);
% fprintf('=== RLHH_Lasso ===\n');
% disp(RLHH_pc);

% Ytr_arr = {Ytr_arr{1}, Ytr_arr{2}, Ytr_arr{3}, Ytr_arr{4}};
% Yte_arr = {Yte_arr{1}, Yte_arr{2}, Yte_arr{3}, Yte_arr{4}};
[PP_Beta_arr, PP_S_arr] = RMFP(Xtr, Ytr_arr, 2);
[PP_pc, PP_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, PP_Beta_arr);
fprintf('=== PP ===\n');
disp(PP_pc);

% S_all = 1:n;
% S_diff = setdiff(S_all,PP_S_arr);
% a = 1;
