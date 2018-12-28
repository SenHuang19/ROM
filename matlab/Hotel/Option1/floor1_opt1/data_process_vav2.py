import pandas as pd
import json
import sys
import os
from os.path import dirname, abspath
d = dirname(dirname(abspath(__file__)))

filename='zone18'
info = json.load(open(filename))

tab=pd.read_csv(os.path.join(d,'raw_data','eplusout.csv'))

# solar radiation	
sol=[]
for key in info["solar"]:
    sol.append(info["solar"][key])

# zone information
zones=[]
for key in sorted(info["inputs"]["zones"]):
    zones.append(info["inputs"]["zones"][key])

adjzones=[]
for key in sorted(info["inputs"]["adjzones"]):
    adjzones.append(info["inputs"]["adjzones"][key])
    
# terminal information
termoutlet=[]
for key in sorted(info["inputs"]["termoutlet"]):
    termoutlet.append(info["inputs"]["termoutlet"][key])
    
# RHT information
rhtinlet=[]
for key in sorted(info["inputs"]["rhtinlet"]):
    rhtinlet.append(info["inputs"]["rhtinlet"][key])

rhtoutlet=[]
for key in sorted(info["inputs"]["rhtoutlet"]):
    rhtoutlet.append(info["inputs"]["rhtoutlet"][key])    


tout=info["tout"]

tab2=pd.DataFrame()
zmt=[]
adjt=[]
zmdm=[] # zone supply air flow rate
zmdt=[] # zone supply air temperature
int=[] # internal load
inlet=[] # reheat coil inlet water temperature
outlet=[] # reheat coil outlet water temperature
mrh=[] # reheat coil water mass flow rate
#rh=[]
#sol=['Environment:Site Diffuse Solar Radiation Rate per Area [W/m2](TimeStep)','Environment:Site Direct Solar Radiation Rate per Area [W/m2](TimeStep)']
for i in range(len(zones)):
    zmt.append(str(zones[i]).upper()+':Zone Mean Air Temperature [C](TimeStep)')
    int.append(str(zones[i]).upper()+':Zone Total Internal Total Heating Rate [W](TimeStep)')
    zmdm.append(str(termoutlet[i]).upper()+':System Node Mass Flow Rate [kg/s](TimeStep)')
    zmdt.append(str(termoutlet[i]).upper()+'System Node Temperature [C](TimeStep)')
    inlet.append(str(rhtinlet[i]).upper()+':System Node Temperature [C](TimeStep)')
    outlet.append(str(rhtoutlet[i]).upper()+':System Node Temperature [C](TimeStep)')
    mrh.append(str(rhtoutlet[i]).upper()+':System Node Mass Flow Rate [kg/s](TimeStep)')
    #rh.append(str(zones[i]).upper()+' RHT COIL:Heating Coil Heating Rate [W](TimeStep)')
    tab2['z'+str(i)]=tab[str(zones[i]).upper()+':Zone Mean Air Temperature [C](TimeStep)']
for i in range(len(adjzones)):
    adjt.append(str(adjzones[i]).upper()+':Zone Mean Air Temperature [C](TimeStep)')
	

tab['t1']=[0]*len(tab)
tab['m1']=[0]*len(tab)
tab['i']=[0]*len(tab)
tab['s']=[0]*len(tab)
tab['rh']=[0]*len(tab)

for i in range(len(zones)):
    tab['t1']=tab['t1']+tab[zmt[i]]*tab[zmdm[i]]
    tab['i']=tab['i']+tab[int[i]]
    tab['m1']=tab['m1']+tab[zmdm[i]]
    tab['rh']=tab['rh']+tab[mrh[i]]*(tab[inlet[i]]-tab[outlet[i]])*4200


for i in range(len(sol)):	
    tab['s']=tab['s']+tab[sol[i]]	


tab2['tout']=tab[tout]
tab2['s']=tab['s']
tab2['i']=tab['i']
tab2['t1']=tab['t1']/tab['m1']
# for cav system
if tab['m1'][0]==0:
    tab2['t1']=tab[zmt[0]]

tab3=pd.read_csv('zone1rawdata.csv')
tab2['t2']=tab3['t1']

for i in range(len(zones)):
    name='sp'+str(i)
    tab2[name]=tab[str(zones[i]).upper()+':Zone Thermostat Heating Setpoint Temperature [C](TimeStep)']
#tab2['sp']=(tab2['sp0']+tab2['sp1']+tab2['sp2']+tab2['sp3']+tab2['sp4'])/5
tab2['m']=tab['m1']
tab2['rh']=tab['rh']

tab2.to_csv(filename+'rawdata.csv')
