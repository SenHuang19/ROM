import os
import numpy as np


for i in np.arange(1,9):
    os.system('Python data_process_vav.py'+' '+str(i))

for i in np.arange(1,9):
    os.system('Python zone_regression_vav.py'+' '+str(i))
