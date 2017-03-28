function [ pc_list, pv_list ] = Metrics_Pearson_Arr( Xte, Yte_arr, Beta_arr )
%METRICS_AVGERROR Summary of this function goes here
%   Detailed explanation goes here

obj_num = size(Yte_arr, 2);
pc_list = zeros(obj_num, 1);
pv_list = zeros(obj_num, 1);
for i=1:obj_num
    Yte_i = Yte_arr{i};
    beta_i = Beta_arr{i};
    [pc, pv] = Metrics_Pearson(Xte, Yte_i, beta_i);
    pc_list(i) = pc;
    pv_list(i) = pv;
end

end

