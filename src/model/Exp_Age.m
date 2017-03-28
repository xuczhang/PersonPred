data_file = strcat('D:/Dataset/PersonPred/age/age_all.mat');

data = load(data_file);
Xtr = data.Xtr;
Ytr = data.Ytr;

Xte = data.Xte;
Yte = data.Yte;

% OLS_Beta = regress(Ytr, Xtr');
% OLS_mse = Metrics_MSE(Xte, Yte, OLS_Beta);
% [OLS_pc, OLS_pv] = Metrics_Pearson(Xte, Yte, OLS_Beta);
% fprintf('OLS_mse=%.3f, OLS_pc=%.3f\n', OLS_mse, OLS_pc);

%tic;
[RLHH_Beta, RLHH_S] = RLHH(Xtr, Ytr);
RLHH_mse = Metrics_MSE( Xte, Yte, RLHH_Beta );
[RLHH_pc, RLHH_pv] = Metrics_Pearson(Xte, Yte, RLHH_Beta);
%toc;
fprintf('RLHH_mse=%.3f, RLHH_pc=%.3f\n', RLHH_mse, RLHH_pc);



