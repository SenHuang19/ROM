import pandas as pd
import json
from collections import OrderedDict



info = json.load(open('fan'),object_pairs_hook=OrderedDict)

#fans
fan=[]
node=[]
for key in info["inputs"]["fans"]:
    fan.append(info["inputs"]["fans"][key])
for key in info["inputs"]["Nodes"]:
    node.append(info["inputs"]["Nodes"][key])



tab=pd.read_csv('run/eplusout.csv')


tab2=pd.DataFrame()
print fan
print node
for i in range(len(fan)):
    name='p'+str(i)
    tab2[name]=tab[str(fan[i]).upper()+':Fan Electric Power [W](TimeStep)']
    name='m'+str(i)
    tab2[name]=tab[node[i].upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']

tab2.to_csv('rawdata.CSV')