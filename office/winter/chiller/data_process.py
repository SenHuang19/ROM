import pandas as pd
import json
from collections import OrderedDict



info = json.load(open('chiller'),object_pairs_hook=OrderedDict)

#fans
coil=[]
outnode=[]
innode=[]
for key in info["inputs"]["coils"]:
    coil.append(info["inputs"]["coils"][key])
for key in info["inputs"]["OutNodes"]:
    outnode.append(info["inputs"]["OutNodes"][key])
for key in info["inputs"]["IntNodes"]:
    innode.append(info["inputs"]["IntNodes"][key])

#rated power

tab=pd.read_csv('run/eplusout.csv')


tab2=pd.DataFrame()
tab3=pd.DataFrame()


tab2['p']=tab[info["inputs"]["name"].upper()+':Chiller Electric Power [W](TimeStep)']

tab3['p']=tab2['p'][1:]
tab2['to']=tab[info["inputs"]["tout"]]
tab3['to']=tab2['to'][1:]
tab3['q']=[0]*len(tab3)
for i in range(len(coil)):
    name1='To'+str(i)
    tab2[name1]=tab[outnode[i].upper()+':System Node Temperature [C](TimeStep)']
    name2='Ti'+str(i)
    tab2[name2]=tab[innode[i].upper()+':System Node Temperature [C](TimeStep)']
    name3='m'+str(i)
    tab2[name3]=tab[innode[i].upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']
    tab3['q']=tab3['q']+(tab2[name2][:-1]-tab2[name1][:-1])*4200*tab2[name3][1:]

tab3.to_csv('rawdata.CSV')