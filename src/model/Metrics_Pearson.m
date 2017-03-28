function [ pc, pv ] = Metrics_Pearson( Xte, Yte, beta )
%METRICS_AVGERROR Summary of this function goes here
%   Detailed explanation goes here
Yte_est = Xte'*beta;
[pc, pv] = corr(Yte, Yte_est);

end

