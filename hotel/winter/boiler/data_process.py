import pandas as pd
import json



info = json.load(open('boiler'))

#the reheat coliers
nodes=[]
for key in info["inputs"]["nodes"]:
    nodes.append(info["inputs"]["nodes"][key])
ahus=[]
for key in info["inputs"]["ahus"]:
    ahus.append(info["inputs"]["ahus"][key])
	
#chiller outlet nodes
boout=[]
for key in info["inputs"]["boiler_outnode"]:
    boout.append(info["inputs"]["boiler_outnode"][key])

#chiller inlet nodes	
boin=[]
for key in info["inputs"]["boiler_innode"]:
    boin.append(info["inputs"]["boiler_innode"][key])
	
#chiller names		
bop=[]

for key in info["outputs"]:
    bop.append(info["outputs"][key])

#outdoor temperature
tout=info["tout"]

#rated chiller capacity

hc=info["hc"]

tab=pd.read_csv('eplusout.csv')


tab2=pd.DataFrame()

tab2['tout']=tab[tout]
tab2['m']=[0]*len(tab)
for i in range(len(nodes)):
    tab2['m']=tab2['m']+tab[str(nodes[i]).upper()+' VAV BOX REHEAT COILDEMAND OUTLET NODE:System Node Mass Flow Rate [kg/s](TimeStep)']

for i in range(len(ahus)):
    tab2['m']=tab2['m']+tab[str(ahus[i]).upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']



#boiler gas	
tab2['gas']=[0]*len(tab)
for i in range(len(bop)):
       tab2['gas']=tab2['gas']+tab[bop[i].upper()+':Boiler Gas Rate [W](TimeStep)']

#sensible heat calculated based on the air side infomration
tab2['q']=[0]*len(tab)
for i in range(len(boin)):
   tab2['dt']=tab[boin[i].upper()+':System Node Temperature [C](TimeStep)']-tab[boout[i].upper()+':System Node Temperature [C](TimeStep)']
   tab2['q']=tab2['q']+tab2['dt']*tab2['m']*4200



tab2.to_csv('rawdata.CSV')
