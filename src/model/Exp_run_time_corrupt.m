k = 4;
p = 400;
bNoise = 0;

n = 1000*k;
dup_num = 10;
factor = 5;

OLS_result = [];
DALM_result = [];
HOMO_result = [];
TORRENT_result = [];
RLHH_result = [];
RMFPGC_result = [];
RMFPMV_result = [];

%for cr = 0.05:0.05:0.4
for cr = 0.05:0.05:0.4

    if bNoise == 1
        noise_str = ''; 
    else
        noise_str = 'nn_';
    end
    n_o = int16(cr*n);
    
    OLS_time = 0;
    DALM_time = 0;
    HOMO_time = 0;
    TORRENT_time = 0;
    RLHH_time = 0;
    RMFPGC_time = 0;
    RMFPMV_time = 0;
    
    
    
    for idx = 1:1:dup_num
        
        data_file = FindDataPath( p, k, cr, bNoise, factor, idx );
        data = load(data_file);
        Xtr = data.Xtr;
        Ytr_arr = data.Ytr_arr;
        Beta_truth = data.Beta_arr;
        

        %% Test different methods
        fprintf('=== [%f] / %d ===\n', cr, idx);

        
        % Ordinary Least Square
        tic;
        OLS_Beta_arr = Baseline_OLS(Xtr, Ytr_arr);
        elapsedTime = toc;
        OLS_time = OLS_time + elapsedTime;
        
        % DALM Method
        tic;
        STOPPING_TIME = -2 ;
        maxTime = 8;
        DALM_Beta_arr = Baseline_DALM(Xtr, Ytr_arr, Beta_truth);
        elapsedTime = toc;
        DALM_time = DALM_time + elapsedTime;

        % Homotopy Method
        tic;
        HOMO_Beta_arr = Baseline_Homotopy(Xtr, Ytr_arr, Beta_truth);
        elapsedTime = toc;
        HOMO_time = HOMO_time + elapsedTime;
        
        % TORRENT
        tic;
        TORR0_Beta_arr = Baseline_TORRENT( Xtr, Ytr_arr, cr);
        elapsedTime = toc;
        TORRENT_time = TORRENT_time + elapsedTime;
        
        % RLHH
        tic;
        [RLHH_Beta_arr, S] = Baseline_RLHH(Xtr, Ytr_arr);
        elapsedTime = toc;
        RLHH_time = RLHH_time + elapsedTime;
        
        % RMFPGC
        tic;
        [RMPFGC_Beta_arr, S] = RMFP(Xtr, Ytr_arr, 1);
        elapsedTime = toc;
        RMFPGC_time = RMFPGC_time + elapsedTime;
        
        % RMFPMV
        tic;
        [RMFPMV_Beta_arr, S] = RMFP(Xtr, Ytr_arr, 2);
        elapsedTime = toc;
        RMFPMV_time = RMFPMV_time + elapsedTime;
        
    
    end
    OLS_result = [OLS_result OLS_time/dup_num];
    DALM_result = [DALM_result DALM_time/dup_num];
    HOMO_result = [HOMO_result HOMO_time/dup_num];
    TORRENT_result = [TORRENT_result TORRENT_time/dup_num];
    RLHH_result = [RLHH_result RLHH_time/dup_num];
    RMFPGC_result = [RMFPGC_result RMFPGC_time/dup_num];
    RMFPMV_result = [RMFPMV_result RMFPMV_time/dup_num];
    
    %fprintf('[%d] - |w-w*|: %f outlier_idx:%d \n', n_o, total_error/21, size(S, 1));
    %fprintf('[%d] - |w-w*|: %f outlier_idx:%d \n', n_o, norm(w_truth-TORRENT_w), size(S, 1));
end
result_path = 'D:/Dropbox/PHD/publications/CIKM2017_PersonPred/experiment/result/';
file_output = strcat(result_path, 'runtime_', num2str(k), 'K_', 'p', num2str(p), '_', noise_str);
file_output = file_output(1:end-1);
save(file_output, 'OLS_result', 'DALM_result', 'HOMO_result', 'TORRENT_result', 'RLHH_result', 'RMFPGC_result', 'RMFPMV_result');
