
import numpy as np
import pandas as pd
import networkx as nx
import collections
 
  
import graspologic
from graspologic.plot import heatmap
import matplotlib.pyplot as plt
from graspologic.plot import heatmap
from graspologic.simulations import sbm
import copy

from graspologic.simulations import sbm
from numpy.random import normal, poisson
import networkx as nx
import copy

import netrd 
from array import *


#####################################################################################

data = pd.read_csv("~/Adj_Comb_UCI_BV2.csv", header=None)
#print(data)

data.shape

 


##################### Distance measure ################

 

data=np.matrix(data)


n1=data.shape[0]
n2=data.shape[1]

print(n1)
print(n2)




  
##############################################################

T=189
m=1899
m2=m*T-1


D1_Frob=[]
D1_Deltacon=[]
D1_diff=[]
D1_HannMik=[]

# list (range(0, m2,m))

for i in range(0, m2,m):  
    #print(i)
    # i=0 # 0, 1899,----, 360810
    c1=i
    c2=m+i
    print(c1)
    print(c2)

    #-------------------G1---------------------------
    #data0=data.loc[0:n1:, c1:c2]
    
    data0=data[0:n1:, c1:c2]
    data0.shape
    #print(data0)
    
    A1=np.matrix(data0)
    G1=nx.from_numpy_array(A1)
     
    G1.number_of_nodes() # number of nodes
    G1.size()            # number of edges
     # print(G1)
     # nx.draw(G1)
    
     
   #-------------------G2---------------------------
    data1=data[0:n1:, (c1+m):(c2+m)]
    data1.shape
    #print(data1)
    
    A2=np.matrix(data1)
    G2=nx.from_numpy_array(A2)
    
    G2.number_of_nodes() # number of nodes
    G2.size()            # number of edges
     #print(G1)
     
     
     
    ##   Frobenius distance #############
    dist_Frob = netrd.distance.Frobenius()
    D_Frob = dist_Frob.dist(G1, G2)
    D_Frob
    
    D1_Frob.append(D_Frob)
    


    ## Deltacon distance ##################
    dist_Deltacon = netrd.distance.DeltaCon()
    D_Deltacon = dist_Deltacon.dist(G1, G2, exact=True, g=None)
    D_Deltacon

    D1_Deltacon.append(D_Deltacon)
    


    ## Hamming and Ipsen-Mikhailov distances ###########
    dist_HannMik = netrd.distance.HammingIpsenMikhailov()
    D_HannMik = dist_HannMik.dist(G1, G2, combination_factor=1)
    D_HannMik

    D1_HannMik.append(D_HannMik)
    

     

print(D1_Frob)
print(D1_Deltacon)
print(D1_HannMik)
    

  
 


plt.plot(D1_Frob, linestyle = 'solid')
plt.plot(D1_Deltacon, linestyle = 'solid')

plt.plot(D1_HannMik, linestyle = 'solid')


# convert array into dataframe
D1_Frob1 = pd.DataFrame(D1_Frob)
D1_Deltacon1 = pd.DataFrame(D1_Deltacon)
D1_HannMik = pd.DataFrame(D1_HannMik)
 
# save the dataframe as a csv file



D1_Frob1.to_csv("~/D_Frob_UCI.csv")
D1_Deltacon1.to_csv("~/D_Deltacon_UCI.csv")
D1_HannMik.to_csv("~/D_HannMik_UCI.csv")



