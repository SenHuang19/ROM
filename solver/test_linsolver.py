# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 17:34:03 2018

@author: Yangyang Fu
@email: yangyang.fu@pnnl.gov
"""

import numpy as np
import linsolver as lin

A=np.array([[1,2],[1,1]])
b=np.array([3,2])

equation = lin.solveLinearEquation(A,b)

equation.solve()

print equation.x
