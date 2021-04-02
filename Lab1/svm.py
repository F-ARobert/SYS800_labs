# -*- coding: utf-8 -*-
"""
Created on Tue Mar 23 13:52:59 2021

@author: mttco
"""
import numpy as np
import sklearn
import time
from sklearn.svm import SVC
from sklearn import svm
from scipy.io import loadmat
from scipy import *
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

reduced_train_database_zone_project = loadmat('reduced_train_database_LBP.mat')
reduced_train_database=reduced_train_database_zone_project.get('reduced_train_database')
x1=reduced_train_database[0:10000]
xtrain=np.array(x1)
train_label=reduced_train_database_zone_project.get('train_label')
y1=train_label[0:10000]
ytrain=np.reshape(np.array(y1),10000)
# x2=reduced_train_database[40000:60000] #pour l entrainement du modèle
# y2=train_label[40000:60000]

del reduced_train_database_zone_project
reduced_test_database_zone_project = loadmat('reduced_test_database_LBP.mat')
reduced_test_database=reduced_test_database_zone_project.get('test_database_reduced')


x2=reduced_test_database

xtest=np.array(x2)

test_label=reduced_test_database_zone_project.get('test_label')

y2=test_label
ytest=np.reshape(np.array(y2),10000)

# ytrain=np.reshape(np.array(y1),1000)
# ytest=np.reshape(np.array(y2),10000)


start_time = time.time()
clf = make_pipeline(StandardScaler(), SVC(C=100,gamma=0.001,kernel='rbf'))
clf.fit(xtrain, ytrain)
t1 = time.time()
temps_entrainement=t1-start_time
start_time = time.time()
ypred=clf.predict(xtest)
result=1-clf.score(xtest,ytest)
t1 = time.time()
temps_test=t1-start_time


##PARTIE CALCUL EN CHAINE
#class SVC(*, C=1.0, kernel='rbf', degree=3, gamma='scale', coef0=0.0, shrinking=True, probability=False, tol=0.001, cache_size=200, class_weight=None, verbose=False, max_iter=- 1, decision_function_shape='ovr', break_ties=False, random_state=None)

# tab1=zeros((49, 4))

# indice=0
# indice1=0.001
# indice2=0.001

# i=1000
# j=2

# # for i in range(1,7):
# for j in range(1,7):
#         a=indice2
#         b=indice1
#         start_time = time.time()
#         clf = make_pipeline(StandardScaler(), SVC(C= a ,gamma= b ,kernel='rbf'))
#         clf.fit(xtrain, ytrain)
#         ypred=clf.predict(xtest)
#         result=1-clf.score(xtest,ytest)
#         t1 = time.time()
#         tab1[indice][0]=a
#         tab1[indice][1]=b
#         tab1[indice][2]=result
#         tab1[indice][3]=t1-start_time
#         indice=indice+1
#         indice1=indice1*10
#         indice2=indice2*10
        
