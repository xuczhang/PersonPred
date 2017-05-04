data_file = strcat('D:/Dataset/PersonPred/bigfive/bigfive_25K.mat');

%data_file = strcat('D:/Dataset/PersonPred/bigfive_liwc/bigfive_12K.mat');

data = load(data_file);
Xtr = data.Xtr;
Ytr_arr = data.Ytr_arr;

Xte = data.Xte;
Yte_arr = data.Yte_arr;

% OLS_Beta_arr = Baseline_OLS(Xtr, Ytr_arr);
% [OLS_pc, OLS_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, OLS_Beta_arr);
% fprintf('=== OLS ===\n');
% disp(OLS_pc);
% 
% OLSL_Beta_arr = Baseline_OLS_Lasso(Xtr, Ytr_arr);
% [OLSL_pc, OLSL_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, OLSL_Beta_arr);
% fprintf('=== OLSL ===\n');
% disp(OLSL_pc);

cr = 0.1;
TORR_Beta_arr = Baseline_TORRENT( Xtr, Ytr_arr, cr);
[TORR_pc, TORR_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, TORR_Beta_arr);
fprintf('=== TORR ===\n');
disp(TORR_pc);

[RLHH_Beta_arr, RLHH_S_arr] = Baseline_RLHH(Xtr, Ytr_arr);
[RLHH_pc, RLHH_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RLHH_Beta_arr);
fprintf('=== RLHH ===\n');
disp(RLHH_pc);

%A = Ytr_arr{[1,2]};
%Ytr_arr = {Ytr_arr{1}, Ytr_arr{4}, Ytr_arr{5}};
%Yte_arr = {Yte_arr{1}, Yte_arr{4}, Yte_arr{5}};
[RMFPGC_Beta_arr, RMFPGC_S_arr] = RMFP(Xtr, Ytr_arr, 1);
%[PP_Beta_arr, PP_S_arr] = RMFP_Lasso(Xtr, Ytr_arr, 1);
[RMFPGC_pc, RMFPGC_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RMFPGC_Beta_arr);
fprintf('=== RMFPGC ===\n');
disp(RMFPGC_pc);

[RMFPMV_Beta_arr, RMFPMV_S_arr] = RMFP(Xtr, Ytr_arr, 2);
%[PP_Beta_arr, PP_S_arr] = RMFP_Lasso(Xtr, Ytr_arr, 1);
[RMFPMV_pc, RMFPMV_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RMFPMV_Beta_arr);
fprintf('=== RMFPMV ===\n');
disp(RMFPMV_pc);


% [PPL_Beta_arr, PPL_S_arr] = RMFP_Lasso(Xtr, Ytr_arr, 1);
% [PPL_pc, PPL_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, PPL_Beta_arr);
% fprintf('=== RMFP_Lasso ===\n');
% disp(PPL_pc);

