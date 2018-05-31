import pandas as pd
import json



info = json.load(open('fan'))

#fans
fan=[]
for key in info["inputs"]["fans"]:
    fan.append(info["inputs"]["fans"][key])

#rated power

c=info["c"]

tab=pd.read_csv('eplusout.csv')


tab2=pd.DataFrame()

for i in range(len(fan)):
    name='p'+str(i)
    tab2[name]=tab[str(fan[i]).upper()+':Fan Electric Power [W](TimeStep)']
    name='m'+str(i)
    tab2[name]=tab[(str(fan[i]).replace(' FAN','')+'_OA-VAV WITH REHEAT_CoolCNode').upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']

tab2.to_csv('rawdata.CSV')
