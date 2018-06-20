import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
import sys
import numpy as np
regr = linear_model.LinearRegression()
import json
import itertools as it


#read data
filename='zone3'
info = json.load(open(filename))

zones=[]
for key in info["inputs"]["zones"]:
    zones.append(info["inputs"]["zones"][key])
    walls=[]
for key in info["inputs"]["walls"]:
    walls.append(info["inputs"]["walls"][key])

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

#x=zip(tab['tout'][1:],tab['s'][1:],tab['i'][1:],tab['t1'][:-1],tab['w1'][1:],tab['hsp'][1:],tab['csp'][1:])
#list = [l + (''.join(l),) for l in list]
#for i in range(len(tab)):
   # for j in range(len(zones)):
       # x[i]=x[i]+(tab['m'+str(j)][i],)
    #x=[l+(tab['m'+str(i)][j].join(l)) for l in x]

#x = [[0] + x for x in List]
#x=zip(tab['tout'][1:],tab['s'][1:],tab['i'][1:],tab['t1'][:-1],tab['w1'][1:],tab['hsp'][1:],tab['csp'][1:],
      #tab['m0'][1:],tab['m1'][1:],tab['m2'][1:],tab['m3'][1:],tab['m4'][1:],tab['m5'][1:],tab['m6'][1:],tab['m7'][1:],tab['m8'][1:],tab['m9'][1:],tab['m10'][1:],tab['m11'][1:],
      #tab['rh0'][1:],tab['rh1'][1:],tab['rh2'][1:],tab['rh3'][1:],tab['rh4'][1:],tab['rh5'][1:],tab['rh6'][1:],tab['rh7'][1:],tab['rh8'][1:],tab['rh9'][1:],tab['rh10'][1:],tab['rh11'][1:])

    #rh.extend(tab['rh'+str(i)][1:])

z=[]
z.append(tab['tout'][1:])
z.append(tab['s'][1:])
z.append(tab['i'][1:])
z.append(tab['t1'][:-1])
for i in range(len(walls)):
    z.append(tab['w'+str(i)][1:])
#z.append(tab['w1'][1:])
z.append(tab['hsp'][1:])
z.append(tab['csp'][1:])
for i in range(len(zones)):
    z.append(tab['m'+str(i)][1:])
for i in range(len(zones)):
    z.append(tab['rh'+str(i)][1:])

y=it.izip_longest(*z)

x=[]
for item in y:
   x.append(item)



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
    #for j in range(len(zones)):
        #x=zip(tab['tout'][i+1:i+2],tab['s'][i+1:i+2],tab['i'][i+1:i+2],t,tab['w1'][i+1:i+2],tab['hsp'][1:],tab['csp'][i+1:i+2],tab['m'+str(j)][i+1:i+2],tab['rh'+str(j)][i+1:i+2])
        #m.append(tab['m'+str(j)[i+1:i+2]])
        #rh.append(tab['rh'+str(j)][i+1:i+2])
    z=[]
    x=[]
    z.append(tab['tout'][i+1:i+2])
    z.append(tab['s'][i+1:i+2])
    z.append(tab['i'][i+1:i+2])
    z.append(t)
    for j in range(len(walls)):
        z.append(tab['w'+str(j)][i+1:i+2])
    z.append(tab['hsp'][i+1:i+2])
    z.append(tab['csp'][i+1:i+2])
    for j in range(len(zones)):
        z.append(tab['m'+str(j)][i+1:i+2])
    for j in range(len(zones)):
        z.append(tab['rh'+str(j)][i+1:i+2])

    k=it.izip_longest(*z)
    for item in k:
        x.append(item)
    #x=zip(tab['tout'][i+1:i+2],tab['s'][i+1:i+2],tab['i'][i+1:i+2],t,tab['w1'][i+1:i+2],tab['hsp'][1:],tab['csp'][i+1:i+2],m,rh)
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
      
