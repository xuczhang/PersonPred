function [] = DataSampling( p, k, cr, bNoise, obj_num, idx)

    %% Initialize the constant
    %p = 100; % feature dimension
    %k = 1;
    %cr = 0.1; % corruption ratio (from 0.1 to 1.2)
    %bNoise = 1;

    n = 1000*k; % total sample number in training data
    n_o = int16(cr*n); % corruption sample number(from 100 to 1200)
    n_u = n - n_o;
    nt = n; % test sample number
    
    % sample X data by normal distribution with mu=0 and cov=I_p
    X_mu = zeros(p, 1);
    X_cov = eye(p);
    Xtr_a = mvnrnd(X_mu, X_cov, n_u)'; %authetic part X    
    Xtr_o = mvnrnd(X_mu, X_cov, n_o)'; % outlier part X
    Xtr = [Xtr_a, Xtr_o];    
    Xte = mvnrnd(X_mu, X_cov, nt)'; % sample testing X data
    
    % init cell array for Y and Beta
    Ytr_arr = {};
    Yte_arr = {};
    Beta_arr = {};
    
for i=1:obj_num
    %% Generate the training sample data
    % sample w by unit norm vector in p dimension
    beta = rand(p, 1);
    beta_norm = norm(beta);
    beta = beta/beta_norm;
    Beta_arr{i} = beta;

    % sample noise eplison for outliers
    e_mu = zeros(n_u, 1);
    e_cov = eye(n_u) * 0.1;
    e_a = mvnrnd(e_mu, e_cov)';

    % generate the authentic samples by y_i = <w, x_i> + e_i
    if bNoise
        ytr_a = Xtr_a'*beta + e_a;
    else
        ytr_a = Xtr_a'*beta;
    end

    %% Generate Training Outlier Data
    % sample corruption vector b as b_i ~ U(-5|y*|_inf, 5|y*|_inf)
    u_range = 5*norm(ytr_a, inf);
    u = -u_range + 2*u_range*rand(n_o,1);

    % sample noise eplison for outliers
    e_mu = zeros(n_o, 1);
    e_cov = eye(n_o) * 0.01;
    e_o = mvnrnd(e_mu, e_cov)';

    % generate outlier ytr_o
    if bNoise
        ytr_o = Xtr_o'*beta + u + e_o;
    else
        ytr_o = Xtr_o'*beta + u;
    end
    
    ytr = [ytr_a; ytr_o];
    Ytr_arr{i} = ytr;

    %% Generate the testing sample data    
    yte = Xte'*beta;
    Yte_arr{i} = yte;

end
    %z = -ytr_all.*(Xtr_all'*w);
    %t = ytr_all - sigmf(Xtr_all'*w, [1 0]);

    %% Save the results into the output file
    %data_file = strcat(data_path, 'synthetic.mat');
    data_file = FindDataPath( p, k, cr, bNoise, obj_num, idx );
    
    save(data_file, 'Xtr', 'Ytr_arr', 'Beta_arr', 'Xte', 'Yte_arr');
end

