import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import sys
import numpy as np
regr = linear_model.LinearRegression()
import json


#read data
filename='zone6'
tab=pd.read_csv(filename+'rawdata.csv')

#training data
tab_train=tab.loc[:7000]
tab_train.to_csv(filename+'train.csv')

#testing data
tab_test=tab.loc[7000:]

tab_test.to_csv(filename+'validation.csv')

#train the model
tab=pd.read_csv(filename+'train.csv')

#tabx=tab.loc[tab['gas'] >0]

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex']) 
x=zip(tab['tout'][1:],tab['s'][1:],tab['i'][1:],tab['t1'][:-1],tab['w1'][1:],tab['hsp'][1:],tab['csp0'][1:],tab['csp1'][1:],tab['csp2'][1:],tab['csp3'][1:],tab['csp4'][1:],tab['m0'][1:],tab['m1'][1:],tab['m2'][1:],tab['m3'][1:],tab['m4'][1:],tab['rh0'][1:],tab['rh1'][1:],tab['rh2'][1:],tab['rh3'][1:],tab['rh4'][1:]) 
y=tab['t1'][1:]
regr.fit(x, y)
y_pre1=regr.predict(x)

tab2=pd.DataFrame()
tab2['prediction']=y_pre1
tab2['real']=y
tab2.to_csv(filename+'comparison.csv')

#validate the model

tab=pd.read_csv(filename+'validation.csv')
pred=[]
test=[]
t=[tab['t1'][0]]
for i in range(len(tab)-1):
    x=zip(tab['tout'][i+1:i+2],tab['s'][i+1:i+2],tab['i'][i+1:i+2],t,tab['w1'][i+1:i+2],tab['hsp'][1:],tab['csp0'][i+1:i+2],tab['csp1'][i+1:i+2],tab['csp2'][i+1:i+2],tab['csp3'][i+1:i+2],tab['csp4'][i+1:i+2],tab['m0'][i+1:i+2],tab['m1'][i+1:i+2],tab['m2'][i+1:i+2],tab['m3'][i+1:i+2],tab['m4'][i+1:i+2],tab['rh0'][1:],tab['rh1'][i+1:i+2],tab['rh2'][i+1:i+2],tab['rh3'][i+1:i+2],tab['rh4'][i+1:i+2]) 
    y_pre2=regr.predict(x)
    t=y_pre2
    pred.append(y_pre2[0])	
    test.append(tab['t1'][i+1])


tab3=pd.DataFrame()

tab3['prediction']=pred

tab3['real']=test

tab3.to_csv(filename+'validation_result.csv')

coefs={}
coefs['a0']=regr.intercept_ 
for i in range(len(regr.coef_)):
   coefs['a'+str(i+1)]=regr.coef_[i]
print coefs

with open(filename+'_result','w') as outfile:
      json.dump(coefs,outfile) 