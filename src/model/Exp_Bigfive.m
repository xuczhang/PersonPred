data_file = strcat('D:/Dataset/PersonPred/bigfive/bigfive_25K.mat');

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
% [RLHH_Beta_arr, RLHH_S_arr] = Baseline_RLHH(Xtr, Ytr_arr);
% [RLHH_pc, RLHH_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, RLHH_Beta_arr);
% fprintf('=== RLHH ===\n');
% disp(RLHH_pc);


[PP_Beta_arr, PP_S_arr] = PersonPred(Xtr, Ytr_arr);
[PP_pc, PP_pv] = Metrics_Pearson_Arr(Xte, Yte_arr, PP_Beta_arr);
fprintf('=== PP ===\n');
disp(PP_pc);

