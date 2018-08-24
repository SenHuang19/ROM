import os
import numpy as np


for i in np.arange(1,6):
    os.system('Python data_process_vav.py'+' 4-'+str(i))

for i in np.arange(1,6):
    os.system('Python zone_regression_vav.py'+' 4-'+str(i))
os.system('Python data_process_vav.py'+' 6')
os.system('Python zone_regression_vav.py'+' 6')