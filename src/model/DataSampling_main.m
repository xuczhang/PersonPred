

% generate the single data
%{
for idx = 1:1:10
DataSampling( p, k, 0.3, bNoise, obj_num, idx);
end
%}

% generate the data per different corruption ratio

p = 200; % feature dimension
k = 4;
cr = 0.5; % corruption ratio (from 0.1 to 1.2)
bNoise = 1;
obj_num = 9;
for cr = 0.05:0.05:0.5
    for idx = 1:1:10
        DataSampling( p, k, cr, bNoise, obj_num, idx);
    end
    
end


% generate the data per different uncorrupted data size
% factor = 5;
% p = 100;
% cr = 0.1;
% bNoise = 1;
% for k = 1:1:10
%     for idx = 1:1:10
%         DataSampling( p, k, cr, bNoise, factor, idx);
%     end
% end


% generate the data per factor number
% cr = 0.2;
% bNoise = 0;
% p = 200;
% k = 2;
% for factor = 3:2:21
%     for idx = 1:1:10
%         DataSampling( p, k, cr, bNoise, factor, idx);
%     end
% end
