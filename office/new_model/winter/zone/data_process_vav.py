import pandas as pd
import json

filename='zone6'
info = json.load(open(filename))

tab=pd.read_csv('eplusout.csv')

# zone information
zones=[]
for key in info["inputs"]["zones"]:
    zones.append(info["inputs"]["zones"][key])

# solar radiation	
sol=[]
for key in info["solar"]:
    sol.append(info["solar"][key])

# wall information
walls=[]
for key in sorted(info["inputs"]["walls"]):
    walls.append(info["inputs"]["walls"][key])

wallareas=[]
for key in info["inputs"]["wallarea"]:
    wallareas.append(info["inputs"]["wallarea"][key])

i=1
for key2 in info["inputs"]["walls"]:
    tab['w'+str(i)]=[0]*len(tab)
    temp=[]
    area=0
    for key in info["inputs"]["walls"][key2]:
          tab['w'+str(i)]=tab['w'+str(i)]+(tab[info["inputs"]["walls"][key2][key].upper()+
             ':Surface Inside Face Temperature [C](TimeStep)']+tab[info["inputs"]["walls"][key2][key].upper()+
                                               ':Surface Outside Face Temperature [C](TimeStep)'])/2*(info["inputs"]["wallarea"][key2][key])
          area=area+info["inputs"]["wallarea"][key2][key]
    tab['w'+str(i)]=tab['w'+str(i)]/area
    i=i+1
                            


tout=info["tout"]
#hsp=info["hsp"]


zmt=[]
zmdm=[]
zmdt=[]
int=[]
inlet=[]
outlet=[]
mrh=[]
rh=[]
#sol=['Environment:Site Diffuse Solar Radiation Rate per Area [W/m2](TimeStep)','Environment:Site Direct Solar Radiation Rate per Area [W/m2](TimeStep)']
for i in range(len(zones)):
    zmt.append(str(zones[i]).upper()+':Zone Mean Air Temperature [C](TimeStep)')
    zmdm.append(str(zones[i]).upper()+' VAV TERM:Zone Air Terminal VAV Damper Position [](TimeStep)')
    #zmdt.append(str(zones[i]).upper()+' VAV TERM DAMPER OUTLET:System Node Temperature [C](TimeStep)')
    int.append(str(zones[i]).upper()+':Zone Total Internal Total Heating Rate [W](TimeStep)')
    #inlet.append(str(zones[i]).upper()+' VAV BOX REHEAT COILDEMAND INLET NODE:System Node Temperature [C](TimeStep)')
    #outlet.append(str(zones[i]).upper()+' VAV BOX REHEAT COILDEMAND OUTLET NODE:System Node Temperature [C](TimeStep)')
    #mrh.append(str(zones[i]).upper()+' VAV BOX REHEAT COILDEMAND INLET NODE:System Node Mass Flow Rate [kg/s](TimeStep)')
    rh.append(str(zones[i]).upper()+' RHT COIL:Heating Coil Heating Rate [W](TimeStep)')


tab['t1']=[0]*len(tab)
tab['m1']=[0]*len(tab)
tab['t2']=[0]*len(tab)
tab['i']=[0]*len(tab)
tab['s']=[0]*len(tab)
tab['rh']=[0]*len(tab)

for i in range(len(zones)):
    tab['t1']=tab['t1']+tab[zmt[i]]*tab[zmdm[i]]
    tab['i']=tab['i']+tab[int[i]]

    #tab['t2']=tab['t2']+tab[zmdt[i]]
    tab['m1']=tab['m1']+tab[zmdm[i]]
    tab['rh']=tab['rh']+tab[rh[i]]


for i in range(len(sol)):	
    tab['s']=tab['s']+tab[sol[i]]	
	
	
tab2=pd.DataFrame()
tab2['t1']=tab['t1']/tab['m1']
for j in range(len(walls)):
    tab2['w'+str(j)]=tab['w'+str(j+1)]
tab2['i']=tab['i']
tab2['s']=tab['s']
tab2['tout']=tab[tout]
#tab2['hsp']=tab[hsp]
tab2['rh']=tab['rh']

for i in range(len(zones)):
    name='m'+str(i)
    tab2[name]=tab[str(zones[i]).upper()+' VAV TERM:Zone Air Terminal VAV Damper Position [](TimeStep)']
    #name='rh'+str(i)
    #tab2[name]=tab[mrh[i]]*(tab[inlet[i]]-tab[outlet[i]])*4200
    name='sp'+str(i)
    tab2[name]=tab[str(zones[i]).upper()+':Zone Thermostat Cooling Setpoint Temperature [C](TimeStep)']
	

tab2.to_csv(filename+'rawdata.CSV')
