import csv

import numpy
import scipy
import scipy.io


class BigFiveDataMgr:

    def __init__(self, train_num):
        # total number is 51865
        self.train_num = train_num
        self.test_num = train_num
        self.total_num = self.train_num + self.test_num

        self.feat_dict = {} # id: feat array
        self.label_dict = {} # id:label
        self.feat_list = []
        self.id_list = []
        pass

    def load_feat_file(self, file):
        with open(file, mode='r') as infile:
            reader = csv.reader(infile)
            self.feat_list = next(reader)[1:]
            for feat in reader:
                id = feat[0]
                if id in self.label_dict:
                    self.id_list.append(id)
                    self.feat_dict[id] = feat[1:]
                if len(self.id_list) == self.total_num:
                    pass
                    # break
        pass

    def load_label_file(self, file):
        with open(file, mode='r') as infile:
            reader = csv.reader(infile)
            next(reader)
            for rows in reader:
                id = rows[0]
                self.label_dict[id] = []

                for label in rows[1:]:
                    self.label_dict[id].append(label)
                #self.id_list.append(id)
                #self.label_dict[id] = rows[2]
                #if len(self.id_list) == 10000:
                #    break
        #self.id_list = self.id_list[1:8000]

    def gen_mat_file(self, mat_file):

        id_list_tr = self.id_list[0:self.train_num]
        id_list_te = self.id_list[self.train_num:self.total_num]
        # generate the Xtr
        Xtr = numpy.zeros(shape=(len(self.feat_list), self.train_num))
        for id_idx, id in enumerate(id_list_tr):
            feat_value_list = self.feat_dict[id]
            for feat_idx, feat in enumerate(feat_value_list):
                Xtr[feat_idx][id_idx] = feat

        # generate the ytr
        #Ytr = numpy.array([numpy.zeros(shape=(self.train_num, 1)), numpy.zeros(shape=(self.test_num, 1)), numpy.zeros(shape=(self.test_num, 1)), numpy.zeros(shape=(self.test_num, 1)), numpy.zeros(shape=(self.test_num, 1))])
        obj_num = len(self.label_dict[self.label_dict.keys()[0]])
        Ytr = numpy.zeros((5,), dtype=numpy.object)
        for i in range(obj_num):
            Ytr[i] = numpy.zeros(shape=(self.train_num, 1))

        for id_idx, id in enumerate(id_list_tr):
            label_arr = self.label_dict[id]
            for label_idx, label in enumerate(label_arr):
                Ytr[label_idx][id_idx] = label

        # generate the Xtr
        Xte = numpy.zeros(shape=(len(self.feat_list), self.test_num))
        for id_idx, id in enumerate(id_list_te):
            feat_value_list = self.feat_dict[id]
            for feat_idx, feat in enumerate(feat_value_list):
                Xte[feat_idx][id_idx] = feat

        # generate the ytr
        Yte = numpy.zeros((5,), dtype=numpy.object)
        for i in range(obj_num):
            Yte[i] = numpy.zeros(shape=(self.test_num, 1))

        #Yte[0] = numpy.zeros(shape=(self.test_num, 1))
        #Yte = numpy.zeros(shape=(self.test_num, 1))
        for id_idx, id in enumerate(id_list_te):
            label_arr = self.label_dict[id]
            for label_idx, label in enumerate(label_arr):
                Yte[label_idx][id_idx] = label

        scipy.io.savemat(mat_file, mdict={'Xtr': Xtr, 'Ytr_arr': Ytr, 'Xte': Xte, 'Yte_arr':Yte})
        pass

if __name__ == '__main__':

    data_dir = 'D:/Dataset/PersonPred/bigfive/'
    #data_dir = '/Users/xuczhang/Dataset/PersonPred/age'
    k = 25
    label_file = data_dir + 'label.csv'
    feat_file = data_dir + 'feature.csv'
    mat_file = data_dir + 'bigfive_' + str(k) + 'K.mat'
    dataMgr = BigFiveDataMgr(k*1000)
    dataMgr.load_label_file(label_file)
    dataMgr.load_feat_file(feat_file)

    dataMgr.gen_mat_file(mat_file)