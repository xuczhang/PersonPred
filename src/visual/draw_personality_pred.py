import glob
import os

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.ticker import LinearLocator, FormatStrFormatter


class DataPlot:

    def __init__(self):
        self.init_plotting()
        pass

    def init_plotting(self):
        plt.rcParams['figure.figsize'] = (17, 5)
        plt.rcParams['font.size'] = 15
        #plt.rcParams['font.family'] = 'Times New Roman'
        plt.rcParams['axes.labelsize'] = plt.rcParams['font.size']
        plt.rcParams['axes.titlesize'] = plt.rcParams['font.size']
        plt.rcParams['legend.fontsize'] = plt.rcParams['font.size']
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


    def exp_personality(self):

        '''
        O_Result = [0, 0.2964, 0.2897, 0.2956, 0.2943, 0.2966]
        C_Result = [0, 0.2705, 0.2639, 0.2678, 0.2700, 0.2702]
        E_Result = [0, 0.2893, 0.2750, 0.2884, 0.2889, 0.2894]
        A_Result = [0, 0.2033, 0.1934, 0.2039, 0.2006, 0.2041]
        N_Result = [0, 0.2563, 0.2433, 0.2561, 0.2556, 0.2567]
        '''

        O_Result = [0, 0.2764, 0.2897, 0.2956, 0.2943, 0.2966]
        C_Result = [0, 0.2605, 0.2639, 0.2678, 0.2700, 0.2708]
        E_Result = [0, 0.2763, 0.2750, 0.2884, 0.2889, 0.2894]
        A_Result = [0, 0.2033, 0.1934, 0.2039, 0.2006, 0.2041]
        N_Result = [0, 0.2413, 0.2433, 0.2561, 0.2556, 0.2567]
        labels = ['Reliab', 'OLS', 'TORR', 'RLHH', 'RMFP-GC', 'RMFP-MV']

        result_set = [O_Result, C_Result, E_Result, A_Result, N_Result]
        ind = np.arange(1)  # the x locations for the groups
        bar_width = 0.15
        factor_width = 0.4
        plt.gca().margins(0.1, 0.1)

        for result in result_set:
            plt.bar(ind, result[1], bar_width, linestyle='-', alpha = 0.9, linewidth=1.5, hatch="|", color='#FA7850', label=labels[1])
            #plt.bar(ind, O_Result[0], bar_width, linestyle='-', linewidth=1.5, color='#DD8401', label='SONMFSRd Twitter')
            ind = ind + bar_width
            plt.bar(ind, result[2], bar_width, linestyle='-', alpha = 0.8, linewidth=1.5, hatch="\\", color='#0174DF', label=labels[2])
            ind = ind + bar_width
            plt.bar(ind, result[3], bar_width, linestyle='-', alpha = 0.8, linewidth=1.5, hatch=".", color='#E6DE10', label=labels[3])
            ind = ind + bar_width
            plt.bar(ind, result[4], bar_width, linestyle='-', alpha = 0.8, linewidth=1.5, hatch="/", color='#782453', label=labels[4])
            ind = ind + bar_width
            plt.bar(ind, result[5], bar_width, linestyle='-', alpha = 0.8, linewidth=1.5, hatch="", color='red', label=labels[5])

            ind = ind + factor_width
            labels = [''] * len(labels)
            a = 1

        #plt.legend(handles=[blue_line])

        '''
        plt.gca().annotate(u'point $\\frac{\\tau}{2}$', xy=(x[2], y1[2]),  xycoords='data',
                        xytext=(30, -10), textcoords='offset points', size=8,
                        arrowprops=dict(arrowstyle='simple', fc='g', ec='none'))
        '''
        plt.xlabel(u'Personality Factors')
        plt.ylabel(u'Pearson Correlation Coefficient')
        plt.ylim([0.15,0.34])

        b = np.arange(5)*10*bar_width
        width = np.arange(5) + factor_width
        plt.xticks(width, ('Openness', 'Conscientiousness', 'Extraversion', 'Agreeableness', 'Neuroticism'))
        #plt.title(u'Subspace-Accuracy/NMI')

        #plt.yaxis.grid(color='gray', linestyle='dashed')

        #plt.gca().legend(bbox_to_anchor = (0.99, 0.99), prop={'size':10})
        plt.gca().legend(loc = 'best', prop={'size': 13})

        plt.show()

        '''
        pp = PdfPages("D:/Dropbox/PHD/publications/ICDM2016/images/" + output_file)
        plt.savefig(pp, format='pdf')
        #pp.savefig(plt.figure())
        pp.close()
        '''





if __name__ == '__main__':

    data_plot = DataPlot()

    ''' runtime '''
    data_plot.exp_personality()






