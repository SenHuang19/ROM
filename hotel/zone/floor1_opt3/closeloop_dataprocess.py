import numpy as np
import pandas as pd
import json


    
tab=pd.read_csv('zone1-1validation.csv')
sum = [[0 for x in range(len(tab))] for y in range(8)] 
for i in range(8):

       coe=json.load(open('zone1-'+str(i+1)+'_result'))
       print(len(coe))
       tab=pd.read_csv('zone1-'+str(i+1)+'validation.csv')
       if i!=4 and i!=7:
           sum[i]=coe['a0']+coe['a1']*tab['tout']+coe['a2']*tab['s']+coe['a3']*tab['i']+coe['a8']*tab['sp0']+coe['a9']*tab['m']+coe['a10']*tab['rh']
       else: 
           sum[i]=coe['a0']+coe['a1']*tab['tout']+coe['a2']*tab['s']+coe['a3']*tab['i']+coe['a12']*tab['sp0']+coe['a13']*tab['m']+coe['a14']*tab['rh']


#sum41=coe41['a0']+coe41['a1']*tab['tout']+coe41['a2']*tab['s']+coe41['a3']*tab['i']+coe41['a9']*tab['sp']+coe41['a10']*tab['m']+coe41['a11']*tab['rh']
#for i in range(len(coe4)-1):
#    sum4=sum4+coe4['a'+str(i+1)]*tab4[c1[i+1]]
#sum4=sum4+coe4['a0']*len(tab4)


tab=pd.DataFrame()
  
for i in range(8):
    tab['b'+str(i)]=sum[i]


tab.to_csv('b.csv')

tab=pd.read_csv('zone1-8validation.csv')
tab1=pd.read_csv('zone1-5validation.csv')
tab2=pd.DataFrame()

tab2['t11']=tab['t1']
tab2['t12']=tab['t2']
tab2['t13']=tab['t3']
tab2['t14']=tab['t4']
tab2['t15']=tab['t5']
tab2['t16']=tab['t6']
tab2['t17']=tab['t7']
tab2['t18']=tab1['t3']


tab2.to_csv('x0.csv')

