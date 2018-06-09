# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 17:34:03 2018

@author: Yangyang Fu
@email: yangyang.fu@pnnl.gov
"""

import numpy as np
import linsolver as lin
import pandas as pd

A=np.array([[1,0,-0.323719248],[0,1,-0.103],[-0.032155748,-0.001475415,1]])
b0=np.array([0.696522001,0.88031142,0.963406113])



dt = 60
tab=pd.read_csv('b.csv')
num=len(tab)-1
print num

x0=np.array([22.61581535,23.29105517,23.85925843])

b=np.array([[tab['b1'].iloc[1],tab['b2'].iloc[1],tab['b3'].iloc[1]]])
#print b
for i in range(2,len(tab)):
     temp=np.array([[tab['b1'].iloc[i],tab['b2'].iloc[i],tab['b3'].iloc[i]]])
#     print temp
     b=np.concatenate((b, temp))
#print b
equation = lin.solveDynamic(A,b,b0,num, x0=x0)

equation.Dysolve()


