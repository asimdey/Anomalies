
import os
import numpy as np
import pandas as pd
import networkx as nx

from ripser import ripser

import collections
from persim import PersistenceImager
from persim import PersImage


  

import graspologic
from graspologic.plot import heatmap
import matplotlib.pyplot as plt

from graspologic.simulations import sbm
from numpy.random import normal, poisson
import networkx as nx
import copy



  


##########################################################################################

# PI function in persim package
# from https://github.com/scikit-tda/persim/blob/master/docs/notebooks/Persistence%20images.ipynb
# from https://github.com/scikit-tda/persim/blob/c35fa049de6c16e9d508e5b92a6df017f9390191/test/test_persim.py#L28
# toy example



##########################################################################################

data = pd.read_csv("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_PD_Comb_Exp4B.csv", header=None)
print(data)

data.shape

n1=data.shape[0]
n2=data.shape[1]

c1=0
c2=2

#data[0:n1, c1:c2]

T=60  # Number of Networks 
T2=T*3

m=500  ## Dimenstion of PI 
m2=m*m
  
##############################################################

VecI = np.empty((m2, T2))

for i in range(0, T2,3):  
    #print(i)
    # i=3 # 0, 3, 6, 9,----
    c1=i
    c2=2+i
    print(c1)
    print(c2)

    #data[0:n1, c1:c2]
    data0=data.loc[0:n1:, c1:c2]
    data1=data0[data0.loc[:,(i+2)]==1]
    
    data2=np.array(data1.loc[0:n1, (c1+1):(c1+2)])
    data2

    pim = PersImage(pixels=(m, m))
    res = pim.transform(data2)
    res.shape

    vec_res=res.flatten() # flatten/vectorize
    vec_res.shape
    
    VecI[0:m2 ,i]=vec_res  
    
    
     
    #mat = np.matrix(VecI)

           

 
# convert array into dataframe
DF = pd.DataFrame(VecI)
DF.shape
# save the dataframe as a csv file
DF.to_csv("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/Exp4B_PI_SBM.csv")


############### plot ##################################
pimgr = PersistenceImager(pixel_size=1)

pimgr.pixel_size = 0.1
pimgr.plot_image(pimgr.transform(data2))







a = np.array([1, 2, 3])
b = np.array([4, 5, 6])
 
# Add the arrays element-wise
c = np.add(a, b)
 
# Print the result
print(c)










