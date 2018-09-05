import pandas as pd
import json
from collections import OrderedDict



info = json.load(open('boiler'),object_pairs_hook=OrderedDict)

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


tab2['p']=tab[info["inputs"]["name"].upper()+':Boiler Gas Rate [W](TimeStep)']


tab2['to']=tab[info["inputs"]["tout"]]

tab2['q']=[0]*len(tab2)
for i in range(len(coil)):
    name1='To'+str(i)
    tab2[name1]=tab[outnode[i].upper()+':System Node Temperature [C](TimeStep)']
    name2='Ti'+str(i)
    tab2[name2]=tab[innode[i].upper()+':System Node Temperature [C](TimeStep)']
    name3='m'+str(i)
    tab2[name3]=tab[innode[i].upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']
    tab2['q']=tab2['q']+(tab2[name2]-tab2[name1])*4200*tab2[name3]

tab2.to_csv('rawdata.CSV')