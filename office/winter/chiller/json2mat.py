import json
from scipy.io import savemat
orig={}

with open('chiller_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig['chiller_result']=temp

print orig
savemat('chiller.mat', orig, oned_as='row')
#print list(dictdump.keys()decode('utf8'))