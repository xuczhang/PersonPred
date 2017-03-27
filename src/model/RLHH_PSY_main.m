%data_file = strcat('./data/', num2str(n_o), '.mat');
%addpath('../../../RLHH/src/RLHH/')
data_file = strcat('~/Dataset/PSY/input.mat');
data = load(data_file);
Xtr = data.Xtr;
Ytr = data.Ytr;
Xte = data.Xte;
Yte = data.Yte;



% OLS
OLS_w = regress(Ytr, Xtr');
OLS_Yte = Xte'*OLS_w;

% RLHH
%[RLHH_w, S] = RLHH(Xtr, Ytr);
%RLHH_Yte = Xte'*w;
a = 1;


