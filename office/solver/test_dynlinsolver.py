# -*- coding: utf-8 -*-
"""
Created on Mon Jun  4 17:34:03 2018

@author: Yangyang Fu
@email: yangyang.fu@pnnl.gov
"""

import numpy as np
import linsolver as lin

A=np.array([[1,2],[1,1]])
b=np.array([[3],[2]])
tStart = 0
tEnd = 1200
dt = 60
x0=np.array([[0],[0]])

b0=np.array([[2],[3]])

equation = lin.solveDynamic(A,b,b0,tStart=tStart, tEnd=tEnd, dt=dt, x0=x0)

equation.Dysolve()


