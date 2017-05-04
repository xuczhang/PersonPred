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

    def draw_residual_iter(self):

        mat_contents = scipy.io.loadmat("sort_r_1")
        Y_residual_1 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_2")
        Y_residual_2 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_3")
        Y_residual_3 = mat_contents["sort_r"].tolist()

        mat_contents = scipy.io.loadmat("sort_r_4")
        Y_residual_4 = mat_contents["sort_r"].tolist()

        x = [i for i in range(1, len(Y_residual_1)+1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.gca().margins(0.1, 0.1)
        #plt.plot(x, Y_residual_1, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_residual_2, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_residual_3, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        plt.plot(x, Y_residual_4, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')

        plt.xlabel(u'index')
        plt.ylabel(u'residual')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()

    def draw_residual(self, matlab_file):

        mat_contents = scipy.io.loadmat(matlab_file)
        Y_residual = mat_contents["sort_r"].tolist()


        x = [i for i in range(1, len(Y_residual)+1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.rcParams['figure.figsize'] = (7, 4)
        plt.gca().margins(0.1, 0.1)

        plt.plot(x, Y_residual, linestyle='', marker='o', markersize=2, linewidth=1.5, color='#5461AA', markeredgecolor='none')
        #plt.plot(x, Y_pred, linestyle='-', marker='o', markersize=7,linewidth=3, color='#0174DF', label='pred')
        #plt.plot(x, y3, linestyle='-', marker='o', linewidth=2, color='y', label='cos')

        plt.xlabel(u'index')
        plt.ylabel(u'residual')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()

    def draw_param_score(self, matlab_file):

        mat_contents = scipy.io.loadmat(matlab_file)
        param_score = mat_contents["param_score"].tolist()[500:1200]
        #param_score = mat_contents["param_score"].tolist()


        x = [i for i in range(500, len(param_score)+500)]
        #x = [i for i in range(1, len(param_score) + 1)]
        #plt.xticks(x, xticks)
        # begin subplots region
        #plt.subplot(121)
        plt.rcParams['figure.figsize'] = (5.4, 4.21)
        plt.gca().margins(0.1, 0.1)
        plt.plot(x, param_score, linestyle='', marker='o', markersize=2, linewidth=2, color='#CF4A5A', markeredgecolor='none')
        #plt.plot(x, Y_pred, linestyle='-', marker='o', markersize=7,linewidth=3, color='#0174DF', label='pred')
        #plt.plot(x, y3, linestyle='-', marker='o', linewidth=2, color='y', label='cos')

        plt.xlabel(u'index')
        plt.ylabel(r'$L$-Value')
        #plt.xlim(1,len(Y_residual)+1)
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        plt.gca().legend(bbox_to_anchor=(0.99, 0.99))
        plt.show()


        #pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/diff_phi1.pdf")
        #plt.savefig(pp, format='pdf')
        plt.close()



if __name__ == '__main__':

    data_plot = DataPlot()

    ### draw residual description
    matlab_file = "sort_r.mat"
    #data_plot.draw_residual(matlab_file)

    ### draw residual iteration
    #data_plot.draw_residual_iter()

    ### draw param score

    matlab_file = "../RLHH/result/param_score.mat"
    #data_plot.draw_param_score(matlab_file)

    ''' beta recovery '''
    #data_plot.exp_beta_recovery()

    ''' runtime '''
    data_plot.exp_runtime()


