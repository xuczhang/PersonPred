function [ recovery_error ] = Metrics_Recovery( Beta_arr, Beta_truth )
%METRICS_AVGERROR Summary of this function goes here
%   Detailed explanation goes here

obj_num = size(Beta_arr, 2);
total_error = 0;
for i=1:obj_num
    Beta_i = Beta_arr{i};
    Beta_truth_i = Beta_truth{i};
    error = norm(Beta_i - Beta_truth_i);
    total_error = total_error + error;
end

recovery_error = total_error / obj_num;

end

