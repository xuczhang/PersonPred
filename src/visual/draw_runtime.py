import glob
import json
import os
import scipy
import scipy.io
import matplotlib.pyplot as plt
import numpy as np
import operator
from matplotlib import cm
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.ticker import LinearLocator, FormatStrFormatter


class DataPlot:

    def __init__(self):
        self.init_plotting()
        pass

    def init_plotting(self):
        plt.rcParams['figure.figsize'] = (6.5, 5)
        plt.rcParams['font.size'] = 15
        #plt.rcParams['font.family'] = 'Times New Roman'
        plt.rcParams['axes.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['axes.titlesize'] = 20
        plt.rcParams['legend.fontsize'] = 12
        plt.rcParams['xtick.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['ytick.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['savefig.dpi'] = plt.rcParams['savefig.dpi']
        plt.rcParams['xtick.major.size'] = 3
        plt.rcParams['xtick.minor.size'] = 3
        plt.rcParams['xtick.major.width'] = 1
        plt.rcParams['xtick.minor.width'] = 1
        plt.rcParams['ytick.major.size'] = 3
        plt.rcParams['ytick.minor.size'] = 3
        plt.rcParams['ytick.major.width'] = 1
        plt.rcParams['ytick.minor.width'] = 1
        #plt.rcParams['legend.frameon'] = True
        #plt.rcParams['legend.loc'] = 'center left'
        #plt.rcParams['legend.loc'] = 'center left'
        plt.rcParams['axes.linewidth'] = 2

        #plt.gca().spines['right'].set_color('none')
        #plt.gca().spines['top'].set_color('none')
        #plt.gca().xaxis.set_ticks_position('bottom')
        #plt.gca().yaxis.set_ticks_position('left')



    def draw_runtime_cr(self, result_dir, k, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        runtime_file = result_dir + 'runtime_' + str(k) + 'K_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(runtime_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT = mat_contents["TORRENT_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()
        Y_RMFPGC = mat_contents["RMFPGC_result"][0].tolist()
        Y_RMFPMV = mat_contents["RMFPMV_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i*0.05 for i in range(1, len(Y_RLHH) + 1)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)

        plt.plot(x, Y_DALM, linestyle='-.', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT, linestyle='-.', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT')
        plt.plot(x, Y_RLHH, linestyle='-', marker='>', markersize=5, linewidth=3, color='#E6DE10', label='RLHH')
        plt.plot(x, Y_RMFPGC, linestyle='--', marker='s', markersize=5, linewidth=3, color='#782453', label='RMFP-GC')
        plt.plot(x, Y_RMFPMV, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RMFP-MV')

        plt.xlabel(u'Corruption Ratio')
        #plt.xlabel(u'Untrustiness Ratio')
        plt.ylabel(u'Running Time(s)')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        #plt.gca().legend(bbox_to_anchor=(0.35, 0.45))
        plt.gca().legend(bbox_to_anchor=(0.40, 0.7))
        #plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.yscale('log')


        if k == 1 and p == 100 and bNoise == 1:
            plt.ylim(0.1, 0.45)  # used for 1K
        elif k == 2 and p == 100 and bNoise == 1:
            plt.ylim(0.05, 0.45)  # used for 2K
        elif k == 4 and p == 100 and bNoise == 1:
            plt.ylim(0.03, 0.35)  # used for 4K
        elif k == 1 and p == 200 and bNoise == 1:
            plt.ylim(0.15, 0.45)
        elif k == 2 and p == 200 and bNoise == 1:
            plt.ylim(0.1, 0.45)
        elif k == 2 and p == 200 and bNoise == 0:
            plt.ylim(-0.02, 0.45)
        elif k == 4 and p == 400 and bNoise == 0:
            plt.ylim(-0.1, 60)
        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()


    def draw_runtime_datasize(self, result_dir, cr, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        runtime_file = result_dir + 'runtime_cr' + str(int(cr*100)) + '_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(runtime_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT = mat_contents["TORRENT_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()
        Y_RMFPGC = mat_contents["RMFPGC_result"][0].tolist()
        Y_RMFPMV = mat_contents["RMFPMV_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i for i in range(1, len(Y_RLHH) + 1)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)

        plt.plot(x, Y_DALM, linestyle='-.', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT, linestyle='-.', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT')
        plt.plot(x, Y_RLHH, linestyle='-', marker='>', markersize=5, linewidth=3, color='#E6DE10', label='RLHH')
        plt.plot(x, Y_RMFPGC, linestyle='--', marker='s', markersize=5, linewidth=3, color='#782453', label='RMFP-GC')
        plt.plot(x, Y_RMFPMV, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RMFP-MV')

        plt.xlabel(u'Data Size(K)')
        plt.ylabel(u'Running Time(s)')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.4, 0.7))
        #plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.yscale('log')

        #plt.ylim(-0.1, 40)
        plt.ylim(-20, 100)

        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()



    def draw_runtime_factor(self, result_dir, cr, p, bNoise):

        if bNoise:
            noise_str = ""
        else:
            noise_str = "_nn"

        runtime_file = result_dir + 'runtime_factor' + str(int(cr*100)) + '_' + 'p' + str(p) + noise_str + '.mat'
        mat_contents = scipy.io.loadmat(runtime_file)
        Y_OLS = mat_contents["OLS_result"][0].tolist()
        Y_DALM = mat_contents["DALM_result"][0].tolist()
        Y_HOMO = mat_contents["HOMO_result"][0].tolist()
        Y_TORRENT = mat_contents["TORRENT_result"][0].tolist()
        Y_RLHH = mat_contents["RLHH_result"][0].tolist()
        Y_RMFPGC = mat_contents["RMFPGC_result"][0].tolist()
        Y_RMFPMV = mat_contents["RMFPMV_result"][0].tolist()

        #x = [i*0.05 for i in range(2, 25)]
        x = [i for i in range(1, len(Y_RLHH) + 1)]
        # plt.xticks(x, xticks)
        # begin subplots region
        # plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        plt.plot(x, Y_DALM, linestyle='-.', marker='o', markersize=5, linewidth=3, color='green', label='DALM')
        plt.plot(x, Y_HOMO, linestyle='-.', marker='v', markersize=5, linewidth=3, color='#5461AA', label='Homotopy')
        plt.plot(x, Y_TORRENT, linestyle='-.', marker='^', markersize=5, linewidth=3, color='cyan', label='TORRENT')
        plt.plot(x, Y_RLHH, linestyle='-', marker='>', markersize=5, linewidth=3, color='#E6DE10', label='RLHH')
        plt.plot(x, Y_RMFPGC, linestyle='--', marker='s', markersize=5, linewidth=3, color='#782453', label='RMFP-GC')
        plt.plot(x, Y_RMFPMV, linestyle='-', marker='o', markersize=5, linewidth=3, color='red', label='RMFP-MV')

        plt.xlabel(u'Factor Number')
        plt.ylabel(u'Running Time(s)')

        # plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        # plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.4, 0.7))
        #plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.yscale('log')

        #plt.ylim(-0.1, 40)
        plt.ylim(-20, 100)

        plt.show()

        #pp = PdfPages("D:/Dropbox/PHD/publications/IJCAI2017_RLHH/images/beta_1.pdf")
        #plt.savefig(pp, format='pdf')
        #plt.close()



    def exp_runtime(self):
        #result_dir = '../RLHH/result/'
        result_dir = 'D:/Dropbox/PHD/publications/CIKM2017_PersonPred/experiment/result/'
        ## Figure 4a
        k = 4
        p = 400
        bNoise = 0
        data_plot.draw_runtime_cr(result_dir, k, p, bNoise)

        ## Figure 4b
        p = 100
        bNoise = 1
        cr = 0.1
        data_plot.draw_runtime_datasize(result_dir, cr, p, bNoise)

        ## Figure 4c
        p = 100
        bNoise = 1
        cr = 0.1
        data_plot.draw_runtime_factor(result_dir, cr, p, bNoise)

if __name__ == '__main__':

    data_plot = DataPlot()

    ''' runtime '''
    data_plot.exp_runtime()


