import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import sys
import numpy as np
regr = linear_model.LinearRegression()
import json
import math

def rmse(x,y):
   sum=0
   for i in range(len(x)-1):
        sum=sum+(1-y[i]/x[i])*(1-y[i]/x[i])
   return math.sqrt(sum/(len(x)-1))*100


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
x=zip(tab['to'],tab['q'])   
y=tab['p']
regr.fit(x, y)
y_pre1=regr.predict(x)

tab2=pd.DataFrame()
tab2['prediction']=y_pre1
tab2['real']=y
tab2.to_csv('comparison.csv')

#validate the model

tab=pd.read_csv('validation.csv')

#x=zip(tab['tout'],tab['PLRs'],tab['hourindex'])
x=zip(tab['to'],tab['q'])
y_pre2=regr.predict(x)

test=tab['p']

tab3=pd.DataFrame()

tab3['prediction']=y_pre2

tab3['real']=tab['p']

tab3.to_csv('validation_result.csv')

plt.scatter(tab3['real'],tab3['prediction'],label='RMSE:'+str(round(rmse(tab3['real'],tab3['prediction']), 0))+'%)',color='y')
#plt.scatter(initial['t5'],tab['t5'],label='option3 RMSE:'+str(round(rmse(tab2['t1'],option3), 3))+')',color='y')

x=np.arange(tab3['real'].max()+1)

plt.plot(x,x*1.2,color='r')
plt.plot(x,x*0.8,color='r')


plt.xlabel('Real [W]',fontsize=10)
plt.ylabel('Prediction [W]',fontsize=10)
plt.xlim(0,x[-1])
plt.ylim(0,x[-1])
plt.legend()
plt.savefig('result.png',bbox_inches = 'tight',pad_inches = 0)  

coefs={}
coefs['e0']=regr.intercept_ 
for i in range(len(regr.coef_)):
   coefs['e'+str(i+1)]=regr.coef_[i]
print coefs

with open('boiler_result','w') as outfile:
      json.dump(coefs,outfile) 