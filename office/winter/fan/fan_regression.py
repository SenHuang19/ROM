import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import sys
import numpy as np
regr = linear_model.LinearRegression()
import json


#read data
tab=pd.read_csv('rawdata.csv')

#training data
tab_train=tab.loc[:7000]
tab_train.to_csv('train.csv')

#testing data
tab_test=tab.loc[7000:]

tab_test.to_csv('validation.csv')

#train the model
tab=pd.read_csv('train.csv')

#tabx=tab.loc[tab['gas'] >0]

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex']) 
x=zip(tab['m0'],tab['m0']*tab['m0'])   
y=tab['p0']
regr.fit(x, y)
y_pre1=regr.predict(x)

tab2=pd.DataFrame()
tab2['prediction']=y_pre1
tab2['real']=y
tab2.to_csv('comparison.csv')

#validate the model

tab=pd.read_csv('validation.csv')

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex'])
x=zip(tab['m0'],tab['m0']*tab['m0'])
y_pre2=regr.predict(x)

test=tab['p0']

tab3=pd.DataFrame()

tab3['prediction']=y_pre2

tab3['real']=tab['p0']

tab3.to_csv('validation_result.csv')

coefs={}
coefs['c0']=regr.intercept_ 
for i in range(len(regr.coef_)):
   coefs['c'+str(i+1)]=regr.coef_[i]
print coefs

with open('fan_result','w') as outfile:
      json.dump(coefs,outfile) 