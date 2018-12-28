import json
from scipy.io import savemat
orig={}
floor='floor2'
for i in range(2,3):
  with open('zone'+str(i)+'_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig[floor+'_'+'zone'+str(i)+'_result']=temp

for i in range(7,8):
  with open('zone2'+str(i)+'_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig[floor+'_'+'zone1'+str(i)+'_result']=temp


print orig
savemat(floor+'.mat', orig, oned_as='row')
#print list(dictdump.keys()decode('utf8'))