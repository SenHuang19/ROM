import numpy as np
import pandas as pd
import json


    
tab=pd.read_csv('zone61validation.csv')
sum = [[0 for x in range(len(tab))] for y in range(4)] 
for i in range(4):

       coe=json.load(open('zone6'+str(i+1)+'_result'))
       print(len(coe))
       tab=pd.read_csv('zone6'+str(i+1)+'validation.csv')
       if i==0:
           sum[i]=coe['a0']+coe['a1']*tab['tout']+coe['a2']*tab['s']+coe['a3']*tab['i']+coe['a6']*tab['sp0']+coe['a7']*tab['m']+coe['a8']*tab['rh']
       elif i==1: 
           sum[i]=coe['a0']+coe['a1']*tab['tout']+coe['a2']*tab['s']+coe['a3']*tab['i']+coe['a8']*tab['sp0']+coe['a9']*tab['m']+coe['a10']*tab['rh']
       else:
           sum[i]=coe['a0']+coe['a1']*tab['tout']+coe['a2']*tab['s']+coe['a3']*tab['i']+coe['a7']*tab['sp0']+coe['a8']*tab['m']+coe['a9']*tab['rh']

#sum41=coe41['a0']+coe41['a1']*tab['tout']+coe41['a2']*tab['s']+coe41['a3']*tab['i']+coe41['a9']*tab['sp']+coe41['a10']*tab['m']+coe41['a11']*tab['rh']
#for i in range(len(coe4)-1):
#    sum4=sum4+coe4['a'+str(i+1)]*tab4[c1[i+1]]
#sum4=sum4+coe4['a0']*len(tab4)


tab=pd.DataFrame()
  
for i in range(4):
    tab['b'+str(i)]=sum[i]


tab.to_csv('b.csv')

tab=pd.read_csv('zone62validation.csv')

tab2=pd.DataFrame()

tab2['t61']=tab['t2']
tab2['t62']=tab['t1']
tab2['t63']=tab['t3']
tab2['t64']=tab['t4']



tab2.to_csv('x0.csv')

