import json
from scipy.io import savemat
orig={}
for i in range(1,2):
  with open('fan'+str(i)+'_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig['fan'+str(i)+'_result']=temp

print orig
savemat('fan.mat', orig, oned_as='row')
#print list(dictdump.keys()decode('utf8'))