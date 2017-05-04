function [ Beta_arr, S_arr ] = Baseline_TORRENT( Xtr, Ytr_arr, cr )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    Beta_arr = {};
    S_arr = {};
    
    obj_num = size(Ytr_arr, 2);
    for i = 1: obj_num
        yi = Ytr_arr{i};
        [beta, S] = Baseline_TORRENT_S(Xtr, yi, cr);
        Beta_arr{i} = beta;
        S_arr{i} = S;
    end

end
