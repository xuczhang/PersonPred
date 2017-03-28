function [ data_file ] = FindDataPath( p, k, cr, bNoise, obj_num, idx )
%MAPDATAPATH Summary of this function goes here
%   Detailed explanation goes here
    
    %data_path = '~/Dataset/PersonPred/synthetic/';
    data_path = 'D:/Dataset/PersonPred/synthetic/';    
    n_o = int16(cr*k*1000);
    
    str_noise = '';
    if ~bNoise
        str_noise = 'nn_';
    end
    data_file = strcat(data_path, num2str(obj_num), 'O_', num2str(k), 'K_', 'p', num2str(p), '_', str_noise, num2str(n_o), '_', num2str(idx), '.mat');
    
end

