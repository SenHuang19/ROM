import pandas as pd
import json



info = json.load(open('chiller'))

#discharge air nodes
DAs=[]
for key in info["inputs"]["disair"]:
    DAs.append(info["inputs"]["disair"][key])

#mixed air nodes
MAs=[]
for key in info["inputs"]["mixair"]:
    MAs.append(info["inputs"]["mixair"][key])

	
#chiller outlet nodes
chout=[]
for key in info["inputs"]["chiller_outnode"]:
    chout.append(info["inputs"]["chiller_outnode"][key])

#chiller inlet nodes	
chin=[]
for key in info["inputs"]["chiller_innode"]:
    chin.append(info["inputs"]["chiller_innode"][key])
	
#chiller names		
chp=[]

for key in info["outputs"]:
    chp.append(info["outputs"][key])

#outdoor temperature
tout=info["tout"]

#rated chiller capacity

cc=info["cc"]

tab=pd.read_csv('eplusout.csv')


tab2=pd.DataFrame()

tab2['tout']=tab[tout]


#sensible heat calculated based on the air side infomration
tab2['q']=[0]*len(tab)
for i in range(len(DAs)):
    tab2['q']=tab2['q']+tab[str(MAs[i]).upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']*1006*(tab[str(MAs[i]).upper()+':System Node Temperature [C](TimeStep)']-tab[str(DAs[i]).upper()+':System Node Temperature [C](TimeStep)'])

#total heat calculated based on the air side infomration	
tab2['qt']=[0]*len(tab)
for i in range(len(chout)):
    tab2['qt']=tab2['qt']+tab[str(chout[i]).upper()+':System Node Mass Flow Rate [kg/s](TimeStep)']*4200*(tab[str(chout[i]).upper()+':System Node Temperature [C](TimeStep)']-tab[str(chin[i]).upper()+':System Node Temperature [C](TimeStep)'])
	
#chiller power		
tab2['c']=[0]*len(tab)
for i in range(len(chp)):
    tab2['c']=tab2['c']+tab[str(chp[i]).upper()+':Chiller Electric Power [W](TimeStep)']	

tab['EIR']=tab2['c']/tab2['q']


#hour index	
num=len(tab2)/12/24
hourindex=[]
for i in range(num):
    for j in range(0,12*24):
		         hourindex.append(j/12)
    
			  

			  
tab2['PLRs']=tab2['q']/cc/len(chp)
             	
tab2['PLR']=tab2['qt']/cc/len(chp)

tab2['hourindex']=hourindex


tab2.to_csv('rawdata.CSV')
