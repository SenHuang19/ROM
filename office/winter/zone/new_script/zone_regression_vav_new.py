import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import numpy as np
regr = linear_model.LinearRegression()
from scipy.optimize import lsq_linear
import json
import collections
import itertools as it
import math
import sys



filename='zone4-'+str(sys.argv[1])
info = json.load(open(filename))

tab=pd.read_csv(filename+'rawdata1.csv')

zones=[]
for key in sorted(info["inputs"]["zones"]):
    zones.append(info["inputs"]["zones"][key])
    
adjzones=[]
for key in sorted(info["inputs"]["adjzones"]):
    adjzones.append(info["inputs"]["adjzones"][key])


#training data
tab_train=tab.loc[:7000]
tab_train.to_csv(filename+'train.csv')

#testing data
tab_test=tab.loc[7000:]

tab_test.to_csv(filename+'validation.csv')

#train the model
tab=pd.read_csv(filename+'rawdata1.csv')

#tabx=tab.loc[tab['gas'] >0]

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex']) 

z=[]
z.append(tab['tout'][:-1])
z.append(tab['s'][:-1])
z.append(tab['i'][:-1])
z.append(tab['t1'][:-1])

for i in range(len(adjzones)):
    z.append(tab['t'+str(i+2)][:-1])
#for i in range(len(zones)):
#    z.append(tab['sp'+str(i)][:-1])
#for i in range(len(zones)):
#    z.append(tab['m'+str(i)][:-1])
    
z.append(tab['sp0'][:-1])  
z.append(tab['m'][:-1])      
z.append(tab['rh'][:-1])


y=it.izip_longest(*z)

x=[]
for item in y:
   x.append(item)


#x=zip(tab['tout'][1:],tab['s'][1:],tab['i'][1:],tab['t1'][:-1],tab['w1'][1:],tab['hsp'][1:],tab['csp0'][1:],tab['csp1'][1:],tab['csp2'][1:],tab['csp3'][1:],tab['csp4'][1:],tab['m0'][1:],tab['m1'][1:],tab['m2'][1:],tab['m3'][1:],tab['m4'][1:],tab['rh0'][1:],tab['rh1'][1:],tab['rh2'][1:],tab['rh3'][1:],tab['rh4'][1:]) 
y=tab['t1'][1:]
res = lsq_linear(x,y,bounds=([0,0,0,0,0,0,0,0,0,-10000,0], [1000., 1000.,1000.,1000.,1000.,1000.,1000.,1000.,1000.,-0.001,1000]))
s=res['x']

print s
y_pre1=[]
for i in range(1,len(tab)):
    y_pre1.append(s[0]*tab['tout'].iloc[i-1]+s[1]*tab['s'].iloc[i-1]+s[2]*tab['i'].iloc[i-1]+s[3]*tab['t1'].iloc[i-1]+s[4]*tab['t2'].iloc[i-1]+s[5]*tab['t3'].iloc[i-1]+s[6]*tab['t4'].iloc[i-1]+s[7]*tab['t5'].iloc[i-1]+s[8]*tab['sp0'].iloc[i-1]+s[9]*tab['m'].iloc[i-1]+s[10]*tab['rh'].iloc[i-1])

tab2=pd.DataFrame()
tab2['prediction']=y_pre1
tab2['real']=y
tab2.to_csv(filename+'comparison.csv')

#validate the model

tab=pd.read_csv(filename+'rawdata2.csv')
pred=[]
test=[]
t=tab['t1'].iloc[0]
for i in range(len(tab)-1):
    t=s[0]*tab['tout'].iloc[i]+s[1]*tab['s'].iloc[i]+s[2]*tab['i'].iloc[i]+s[3]*t+s[4]*tab['t2'].iloc[i]+s[5]*tab['t3'].iloc[i]+s[6]*tab['t4'].iloc[i]+s[7]*tab['t5'].iloc[i]+s[8]*tab['sp0'].iloc[i]+s[9]*tab['m'].iloc[i]+s[10]*tab['rh'].iloc[i]
    #x=zip(tab['tout'][i+1:i+2],tab['s'][i+1:i+2],tab['i'][i+1:i+2],t,tab['w1'][i+1:i+2],tab['hsp'][1:],tab['csp'][i+1:i+2],m,rh)
    pred.append(t)
    test.append(tab['t1'].iloc[i+1])


tab3=pd.DataFrame()

tab3['prediction']=pred

tab3['real']=test

tab3.to_csv(filename+'validation_result.csv')

