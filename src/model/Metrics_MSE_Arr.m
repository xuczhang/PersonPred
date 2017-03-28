function [ avg_mse ] = Metrics_MSE_Arr( Xte, Yte_arr, Beta_arr )
%METRICS_AVGERROR Summary of this function goes here
%   Detailed explanation goes here

obj_num = size(Yte_arr, 2);
n = size(Xte, 2);
total_error = 0;
for i=1:obj_num
    Yte_i = Yte_arr{i};
    beta_i = Beta_arr{i};
    error = Metrics_MSE(Xte, Yte_i, beta_i);
    total_error = total_error + error;
end

avg_mse = total_error / n;

end

