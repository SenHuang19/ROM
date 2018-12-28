import numpy as np
import pandas as pd
import json

coe4=json.load(open('zone2_result'))
coe5=json.load(open('zone27_result'))

tab4=pd.read_csv('zone2validation.csv')
sum4=[0]*len(tab4)
sum4=coe4['a0']+coe4['a1']*tab4['tout']+coe4['a2']*tab4['s']+coe4['a3']*tab4['i']+coe4['a6']*tab4['sp']+coe4['a7']*tab4['m']+coe4['a8']*tab4['rh']

tab5=pd.read_csv('zone27validation.csv')
sum5=[0]*len(tab5)
sum5=coe5['a0']+coe5['a1']*tab5['tout']+coe5['a2']*tab5['s']+coe5['a3']*tab5['i']+coe5['a6']*tab5['sp0']+coe5['a7']*tab5['m']+coe5['a8']*tab5['rh']

tab=pd.DataFrame()
tab['b2']=sum4
tab['b27']=sum5
tab.to_csv('b.csv')

tab2=pd.DataFrame()
tab2['t2']=tab4['t1']
tab2['t27']=tab5['t1']
tab2.to_csv('x0.csv')