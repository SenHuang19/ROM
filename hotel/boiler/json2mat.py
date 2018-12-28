import json
from scipy.io import savemat
orig={}

with open('boiler_result') as handle:
    dictdump = json.loads(handle.read())
    temp={}
    for key in dictdump.keys():
#            print key.decode('utf8')
            temp[key.encode("utf-8")]=dictdump[key]
#            print dictdump[key.decode('utf8')]

    print temp
    orig['boiler_result']=temp

print orig
savemat('boiler.mat', orig, oned_as='row')
#print list(dictdump.keys()decode('utf8'))