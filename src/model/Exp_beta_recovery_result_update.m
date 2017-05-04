
p = 400;
k = 4;
bNoise = 0;
obj_num = 5;
noise_str = '';
if ~bNoise
   noise_str = 'nn_'; 
end

result_path = 'D:/Dropbox/PHD/publications/CIKM2017_PersonPred/experiment/result/';
data_file = strcat(result_path, 'beta_', num2str(k), 'K_', 'p', num2str(p), '_', noise_str);
data_file = data_file(1:end-1);
data_file = strcat(data_file, '.mat');
data = load(data_file);

OLS_result = data.OLS_result;
DALM_result = data.DALM_result;
HOMO_result = data.HOMO_result;
TORRENT0_result = data.TORRENT0_result;
TORRENT25_result = data.TORRENT25_result;
TORRENT50_result = data.TORRENT50_result;
RLHH_result = data.RLHH_result;
RMFPGC_result = data.RMFPGC_result;
RMFPMV_result = data.RMFPMV_result;


DALM_result=[2.4906760053086127E-5	3.7280152736324004E-5	6.017474045675697E-5	1.456688290437281E-4	1.8890984941908115E-4	1.3762897910283455E-4	3.010575562756539E-5	6.338419044563433E-5];
HOMO_result=[0.7287555205551277	1.0252304984480949	1.2098846634372749	1.4156722615485728	1.584129383333287	1.8587952429908654	2.0543520818995007	2.26959632211357];

save(data_file, 'OLS_result', 'DALM_result', 'HOMO_result', 'TORRENT0_result', 'TORRENT25_result', 'TORRENT50_result', 'RLHH_result', 'RMFPGC_result', 'RMFPMV_result');
