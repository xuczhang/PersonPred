function [ Beta_arr ] = Baseline_OLS_Lasso( Xtr, Ytr_arr )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    Beta_arr = {};
    
    obj_num = size(Ytr_arr, 2);
    for i = 1: obj_num
        Ytr_i = Ytr_arr{i};
        %OLS_beta_2 = regress(Ytr_i, Xtr');
        OLS_beta_i = lasso(Xtr', Ytr_i, 'Lambda', 0.005);
        %OLS_beta_i = lasso(Xtr', Ytr_i, 'Lambda', 0.000001);
        
        Beta_arr{i} = OLS_beta_i;
    end

end