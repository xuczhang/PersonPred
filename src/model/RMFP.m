function [ Beta_arr, S ] = RMFP( Xtr, Ytr_arr, strategy)

% if strategy == 1, use global_consensus strategy
% if strategy == 2, use majority voting strategy

p = size(Xtr, 1);
n = size(Xtr, 2);

% init active objective set
obj_num = size(Ytr_arr, 2);
obj_set = 1:obj_num;

% init the Beta_arr
Beta_arr = {};

% init S_arr and Res_arr
S_arr = {};
Res_arr = {};
tau_arr = {}; % store the old_tau value
for i=1:obj_num
    S_i = 1:n;
    S_i = S_i';
    S_arr{i} = S_i;
    
    res_i = zeros(n,1);
    Res_arr{i} = res_i;
    tau_arr{i} = n;

end

S = 1:n;
S = S';

MAX_ITER = 100;
MIN_THRES = 1e-3;
%MIN_THRES =0.01;
for iter=1:MAX_ITER
    
    for idx = 1:size(obj_set, 2)
        i = obj_set(idx);
        y_i = Ytr_arr{i};
        beta_i = update_beta(Xtr, y_i, S);
        
        res_old_i = Res_arr{i};
        res_i = update_res(Xtr, y_i, beta_i);
        
        tau_i = HTSearch(res_i, tau_arr{i});
        %outlier_k = HT_ParamSearch(res);
        %outlier_k = 1000;
        %fprintf('outlier_idx=%d\n', outlier_k);
        S_i = HT(res_i, tau_i);
        
        Beta_arr{i} = beta_i;
        S_arr{i} = S_i;
        Res_arr{i} = res_i;
        tau_arr{i} = tau_i;
        
        s_i = size(S_i, 1);
        %fprintf('[%d] residual=%f\n', idx, norm(res_i(S_i)-res_old_i(S_i))/s_i);
        if norm(res_i(S_i)-res_old_i(S_i))/s_i <= MIN_THRES
        %if norm(res_i(S))/n <= MIN_THRES
            %fprintf('Finished!!!');
            obj_set = obj_set(obj_set~=i);
            break;
        end
    end
   
    if strategy == 1
        S = global_consensus(S_arr);  
    else
        S = majority_voting(S_arr, n);  
    end
    
    
    if size(obj_set, 2) == 0
        break;
    end
    
    if(iter == MAX_ITER)
        fprintf('Max Iteration Reached!!!');
    end
    
end

end

function S = majority_voting(S_arr, n)

    WS = zeros(n,1);
    obj_num = size(S_arr, 2);
    for i = 1:obj_num
        S_i = S_arr{i};
        WS_i = zeros(n,1);
        WS_i(S_i) = 1;
        WS = WS + WS_i;
        %S = union(S, S_arr{i}); 
    end
    
    %S = find(WS >= ceil(obj_num/2));
    S = find(WS >= ceil(obj_num/2));
    %S= (1:1000)';

end

function S = global_consensus(S_arr)
       
    obj_num = size(S_arr, 2);
    S = S_arr{1};
    for i = 2:obj_num
        S = intersect(S, S_arr{i});
    end

end

function res = update_res(X, y, w)    
    n = size(y, 1);
    res = zeros(n, 1);
    for i = 1:n
        X_i = X(:,i);
        y_i = y(i);
        res(i) = abs(y_i - X_i'*w);
    end
end

function beta = update_beta(X, y, S)    
    y_S = y(S);
    X_S = X(:,S);
    %beta = lasso(X_S', y_S, 'Lambda', 0.005);
    beta = inv(X_S*X_S')*X_S*y_S;
    
end



function tau = HTSearch(res, old_tau)
    [sort_r, sort_ri] = sort(res);    
    plot(sort_r, 'o', 'MarkerSize',2, 'MarkerEdgeColor','blue');
    n = size(res, 1);
    
    for tau = old_tau:-1:1
    %for tau = n:-1:1
        %tau_ratio = 2;
        tau_ratio = 2;
        constrained = constaint(tau, tau_ratio, sort_r);
        
        if constrained
            break;
        end
        
    end
    
    if tau == 1
        tau = old_tau;
        fprintf('Error: no index found!!!\n');
    end

    
end

function constrained = constaint(tau, tau_ratio, sort_r)
    n = size(sort_r, 1);
    r_n = sort_r(n);
    %tau_ratio = 
    %magic_point = floor(tau_ratio*tau);
    magic_point = floor(tau - n/2);
    %magic_point = floor(tau/2);
    [tau_o, tau_o_res] = cal_mean_tau(magic_point, sort_r);
    res_k = sort_r(tau);
    %thres = (tau_mean_res+(tau-tau_mean)/(n-tau_mean)*(r_n-tau_mean_res));
    
    % method1: r_tau <= delta^1/2 * tau/tau' * r_tau', where delta is a
    % parameter to adjust the r_tau threshold
    %thres = sqrt(thres_ratio*tau*tau_mean_res/tau_mean);
    thres = tau_ratio*tau*tau_o_res/tau_o;
    %thres = 2*tau*tau_o_res/tau_o;
    %thres_2 = (r_n + tau_o_res)/2;
    
    %thres_new = (tau/(tau-n/2))*tau*tau_o_res/tau_o;

    %thres = min(thres_1, thres_2);
    
    constrained = 0;
    if res_k <= thres
        constrained = 1;
    end
   
end

% return the mean tau number 
function [tau_mean, tau_res] = cal_mean_tau(thres_k, sort_r)
    tau_res = sqrt(norm(sort_r(1:thres_k))^2/thres_k);
    [a, tau_mean] = min(abs(sort_r-tau_res));
    %thres = sqrt(p* norm(sort_r(1:k))^2);
end

function S = HT(res, k)
    [m mi] = sort(res);    
    S = mi(1:k);
end