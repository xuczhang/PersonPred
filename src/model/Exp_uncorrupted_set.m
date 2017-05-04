k = 4;
p = 200;
bNoise = 1;
cr = 0.4;
factor = 9;

n = 1000*k;
dup_num = 10;
n_o = int16(cr*n);

if bNoise == 1
    noise_str = ''; 
else
    noise_str = 'nn_';
end


TORRENT0_f1 = 0;
TORRENT25_f1 = 0;
TORRENT50_f1 = 0;
RLHH_f1 = 0;
RMPFGC_f1 = 0;
RMPFMV_f1 = 0;

TORRENT0_precision = 0;
TORRENT25_precision = 0;
TORRENT50_precision = 0;
RLHH_precision = 0;
RMPFGC_precision = 0;
RMPFMV_precision = 0;

TORRENT0_recall = 0;
TORRENT25_recall = 0;
TORRENT50_recall = 0;
RLHH_recall = 0;
RMPFGC_recall = 0;
RMPFMV_recall = 0;

S_truth = [ones(n-n_o, 1) ; zeros(n_o, 1)];

fprintf('=== cr:%f ===\n', cr);
for idx = 1:1:dup_num

    %data_file = strcat('D:/Dataset/RLHH/', num2str(k), 'K_', 'p', num2str(p), '_', noise_str, num2str(n_o), '_', num2str(idx), '.mat');
    data_file = FindDataPath( p, k, cr, bNoise, factor, idx );
    data = load(data_file);
    Xtr = data.Xtr;
    Ytr_arr = data.Ytr_arr;
    Beta_truth = data.Beta_arr;

    % TORRENT80
    %{
    [TORRENT80_w, TORRENT80_S] = Baseline_TORRENT( Xtr, ytr, 1.8*cr);
    S_TORR80 = zeros(n, 1);
    S_TORR80(TORRENT80_S) = 1;
    stat_TORR80 = confusionmatStats(S_truth, S_TORR80);
    TORRENT80_f1 = TORRENT80_f1 + stat_TORR80.Fscore(2);   
    %}
    
    % TORRENT50
    [TORRENT50_beta_arr, TORRENT50_S_arr] = Baseline_TORRENT( Xtr, Ytr_arr, 1.5*cr);
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption( TORRENT50_S_arr, S_truth, n );
    TORRENT50_f1 = TORRENT50_f1 + f1_score;
    TORRENT50_precision = TORRENT50_precision + precision;
    TORRENT50_recall = TORRENT50_recall + recall;
    
    
    % TORRENT25
    [TORRENT25_beta_arr, TORRENT25_S_arr] = Baseline_TORRENT( Xtr, Ytr_arr, 1.25*cr);
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption( TORRENT25_S_arr, S_truth, n );
    TORRENT25_f1 = TORRENT25_f1 + f1_score;
    TORRENT25_precision = TORRENT25_precision + precision;
    TORRENT25_recall = TORRENT25_recall + recall;       
            
    % TORRENT0
    [TORRENT0_beta_arr, TORRENT0_S_arr] = Baseline_TORRENT( Xtr, Ytr_arr, cr);
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption( TORRENT0_S_arr, S_truth, n );
    TORRENT0_f1 = TORRENT0_f1 + f1_score;
    TORRENT0_precision = TORRENT0_precision + precision;
    TORRENT0_recall = TORRENT0_recall + recall;
    
    % RLHH    
    [RLHH_Beta_arr, RLHH_S_arr] = Baseline_RLHH(Xtr, Ytr_arr);
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption(RLHH_S_arr, S_truth, n);
    RLHH_f1 = RLHH_f1 + f1_score;
    RLHH_precision = RLHH_precision + precision;
    RLHH_recall = RLHH_recall + recall;
    
    % RMFP_GC
    [RMPFGC_Beta_arr, RMPFGC_S] = RMFP(Xtr, Ytr_arr, 1);
    RMPFGC_S_arr = {RMPFGC_S};
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption(RMPFGC_S_arr, S_truth, n);
    RMPFGC_f1 = RMPFGC_f1 + f1_score;
    RMPFGC_precision = RMPFGC_precision + precision;
    RMPFGC_recall = RMPFGC_recall + recall;
    
    % RMFP_MV
    [RMPFMV_Beta_arr, RMPFMV_S] = RMFP(Xtr, Ytr_arr, 2);
    RMPFMV_S_arr = {RMPFMV_S};
    [ accuracy, precision, recall, f1_score ] = Metrics_Corruption(RMPFMV_S_arr, S_truth, n);
    RMPFMV_f1 = RMPFMV_f1 + f1_score;
    RMPFMV_precision = RMPFMV_precision + precision;
    RMPFMV_recall = RMPFMV_recall + recall;


end

%fprintf('\nTORR80: %.3f\n', TORRENT80_f1/dup_num);
fprintf('\nTORR50: %.3f,%.3f,%.3f\n', TORRENT50_precision/dup_num, TORRENT50_recall/dup_num, TORRENT50_f1/dup_num);
fprintf('TORR25: %.3f,%.3f,%.3f\n', TORRENT25_precision/dup_num, TORRENT25_recall/dup_num, TORRENT25_f1/dup_num);
fprintf('TORR0: %.3f,%.3f,%.3f\n', TORRENT0_precision/dup_num, TORRENT0_recall/dup_num, TORRENT0_f1/dup_num);
fprintf('RLHH: %.3f,%.3f,%.3f\n', RLHH_precision/dup_num, RLHH_recall/dup_num, RLHH_f1/dup_num);
fprintf('RMPFGC: %.3f,%.3f,%.3f\n', RMPFGC_precision/dup_num, RMPFGC_recall/dup_num, RMPFGC_f1/dup_num);
fprintf('RMPFMV: %.3f,%.3f,%.3f\n', RMPFMV_precision/dup_num, RMPFMV_recall/dup_num, RMPFMV_f1/dup_num);
