import json
from scipy.io import savemat
orig={}
for i in range(5,7):
  with open('zone'+str(i)+'_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

#    print temp
    orig['zone'+str(i)+'_result']=temp

for i in range(1,6):
  with open('zone4-'+str(i)+'_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig['zone4_'+str(i)+'_result']=temp

#print orig
savemat('Bot_floor.mat', orig, oned_as='row')
#print list(dictdump.keys()decode('utf8'))