k = 1;
p = 100;
bNoise = 1;
factor = 5;

n = 1000*k;
dup_num = 10;


OLS_result = [];
DALM_result = [];
HOMO_result = [];
TORRENT50_result = [];
TORRENT25_result = [];
TORRENT0_result = [];
RLHH_result = [];
RMFPGC_result = [];
RMFPMV_result = [];

fprintf('=== k=%d, p=%d, bNoise=%d ===\n', k, p, bNoise);
for cr = 0.05:0.05:0.4

    if bNoise == 1
        noise_str = ''; 
    else
        noise_str = 'nn_';
    end
    n_o = int16(cr*n);
    
    OLS_err = 0;
    DALM_err = 0;
    HOMO_err = 0;
    TORR0_err = 0;
    TORRENT25_err = 0;
    TORRENT50_err = 0;
    RLHH_err = 0;
    RMFPGC_err = 0;
    RMFPMV_err = 0;
    
    
    for idx = 1:1:dup_num
            
        data_file = FindDataPath( p, k, cr, bNoise, factor, idx );
        
        %data_file = strcat('D:/Dataset/PersonPred/synthetic', num2str(k), 'K_', 'p', num2str(p), '_', noise_str, num2str(n_o), '_', num2str(idx), '.mat');
        data = load(data_file);
        Xtr = data.Xtr;
        Ytr_arr = data.Ytr_arr;
        Beta_truth = data.Beta_arr;


        %% Test different methods
        fprintf('=== [%f] / %d ===\n', cr, idx);

        % Ordinary Least Square
        OLS_Beta_arr = Baseline_OLS(Xtr, Ytr_arr);
        OLS_err = OLS_err + Metrics_Recovery( OLS_Beta_arr, Beta_truth );

        % DALM Method
        DALM_Beta_arr = Baseline_DALM(Xtr, Ytr_arr, Beta_truth);
        DALM_err = DALM_err + Metrics_Recovery( DALM_Beta_arr, Beta_truth );

        % Homotopy Method
        HOMO_Beta_arr = Baseline_Homotopy(Xtr, Ytr_arr, Beta_truth);
        HOMO_err = HOMO_err + Metrics_Recovery( HOMO_Beta_arr, Beta_truth );

        
        % TORRENT0
        TORR0_Beta_arr = Baseline_TORRENT( Xtr, Ytr_arr, cr);
        TORR0_err = TORR0_err + Metrics_Recovery( TORR0_Beta_arr, Beta_truth );
        % TORRENT25
        total_error = 0;
        for ecr = 0.75*cr:0.5/20*cr:1.25*cr
            TORRENT25_Beta_arr = Baseline_TORRENT( Xtr, Ytr_arr, ecr);
            total_error = total_error + Metrics_Recovery(TORRENT25_Beta_arr, Beta_truth);
        end    
        TORRENT25_err = TORRENT25_err + total_error/21;
        
        % TORRENT50
        total_error = 0;
        for ecr = 0.5*cr:1/20*cr:1.5*cr
            TORRENT50_Beta_arr = Baseline_TORRENT( Xtr, Ytr_arr, ecr);
            total_error = total_error + Metrics_Recovery(TORRENT50_Beta_arr, Beta_truth);
        end    
        TORRENT50_err = TORRENT50_err + total_error/21;

        % RLHH
        [RLHH_Beta_arr, S] = Baseline_RLHH(Xtr, Ytr_arr);
        RLHH_err = RLHH_err + Metrics_Recovery(RLHH_Beta_arr, Beta_truth);  

        % RMPF Global Consensus
        [RMPFGC_Beta_arr, S] = RMFP(Xtr, Ytr_arr, 1);
        RMFPGC_err = RMFPGC_err + Metrics_Recovery(RMPFGC_Beta_arr, Beta_truth);  
        
        % RMPF Majority Voting
        [RMPFMV_Beta_arr, S] = RMFP(Xtr, Ytr_arr, 2);
        RMFPMV_err = RMFPMV_err + Metrics_Recovery(RMPFMV_Beta_arr, Beta_truth);  
        
    end
    OLS_result = [OLS_result OLS_err/dup_num];
    DALM_result = [DALM_result DALM_err/dup_num];
    HOMO_result = [HOMO_result HOMO_err/dup_num];
    TORRENT0_result = [TORRENT0_result TORR0_err/dup_num];
    TORRENT25_result = [TORRENT25_result TORRENT25_err/dup_num];    
    TORRENT50_result = [TORRENT50_result TORRENT50_err/dup_num];    
    RLHH_result = [RLHH_result RLHH_err/dup_num];
    RMFPGC_result = [RMFPGC_result RMFPGC_err/dup_num];
    RMFPMV_result = [RMFPMV_result RMFPMV_err/dup_num];
    

end
result_path = 'D:/Dropbox/PHD/publications/CIKM2017_PersonPred/experiment/result/';
file_output = strcat(result_path, 'beta_', num2str(k), 'K_', 'p', num2str(p), '_', noise_str);
file_output = file_output(1:end-1);
save(file_output, 'OLS_result', 'DALM_result', 'HOMO_result', 'TORRENT0_result', 'TORRENT25_result', 'TORRENT50_result', 'RLHH_result', 'RMFPGC_result', 'RMFPMV_result');
