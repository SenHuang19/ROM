import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math
import json
import math


def rmse(x,y):
   sum=0
   for i in range(len(x)):
        sum=sum+(x.iloc[i]-y.iloc[i])*(x[i]-y[i])
   return math.sqrt(sum/len(x))


tab2=pd.read_csv('validation_result.csv')
tab3=pd.read_csv('validation_result_origin.csv')


x=np.arange(20,tab2['real'].max()+1)


plt.scatter(tab2['real'],tab2['prediction'],color='y')
#plt.scatter(tab3['real'],tab3['prediction_with_datacenter'],color='b')



plt.plot(x,x+2.0/9*5,label='2degF(RMSE:'+str(round(rmse(tab2['real'],tab2['prediction'])))+')',color='r')
plt.plot(x,x-2.0/9*5,color='r')

#plt.plot(x[7000:],tab[tout][7000:],label='testing data')

plt.xlabel('Real [degC]',fontsize=10)
plt.ylabel('Prediction [degC]',fontsize=10)
#plt.xticks(xnum,xlab)
plt.xlim(20,x[-1])
plt.ylim(20,x[-1])
plt.legend()
plt.savefig('validation.png',bbox_inches = 'tight',pad_inches = 0)
plt.show()
