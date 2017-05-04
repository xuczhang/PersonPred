function [ Beta_arr ] = Baseline_DALM( Xtr, Ytr_arr, Beta_truth_arr )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    Beta_arr = {};
    S_arr = {};
    
    obj_num = size(Ytr_arr, 2);
    for i = 1: obj_num
        yi = Ytr_arr{i};
        beta_truth_i = Beta_truth_arr{i};
        
        STOPPING_TIME = -2 ;
        maxTime = 8;
        beta = Baseline_DALM_CBM(Xtr', yi, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', beta_truth_i, 'maxtime', maxTime, 'maxiteration', 1e6);
        Beta_arr{i} = beta;
    end

end