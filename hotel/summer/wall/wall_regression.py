import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import sys
import numpy as np
regr = linear_model.LinearRegression()
import json


#read data
name='wall2-4'
tab=pd.read_csv(name+'.csv')

#training data
tab_train=tab.loc[:7000]
tab_train.to_csv(name+'_train.csv')

#testing data
tab_test=tab.loc[7000:]

tab_test.to_csv(name+'_validation.csv')

#train the model
tab=pd.read_csv(name+'_train.csv')

#tabx=tab.loc[tab['gas'] >0]

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex']) 
x=zip(tab['t1'][1:],tab['t2'][1:],tab['w1'][:-1])
y=tab['w1'][1:]
regr.fit(x, y)
y_pre1=regr.predict(x)

tab2=pd.DataFrame()
tab2['prediction']=y_pre1
tab2['real']=y
tab2.to_csv(name+'_comparison.csv')

#validate the model

tab=pd.read_csv(name+'_validation.csv')
pred=[]
test=[]
t=[tab['w1'][0]]
for i in range(len(tab)-1):
    x=zip(tab['t1'][i+1:i+2],tab['t2'][i+1:i+2],t)  
    y_pre2=regr.predict(x)
    t=y_pre2
    pred.append(y_pre2[0])	
    test.append(tab['w1'][i+1])


tab3=pd.DataFrame()

tab3['prediction']=pred

tab3['real']=test

tab3.to_csv(name+'_validation_result.csv')

coefs={}
coefs['b0']=regr.intercept_ 
for i in range(len(regr.coef_)):
   coefs['b'+str(i+1)]=regr.coef_[i]
print coefs

with open(name+'_result','w') as outfile:
      json.dump(coefs,outfile) 