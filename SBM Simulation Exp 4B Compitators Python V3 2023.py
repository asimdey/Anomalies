
 
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

  


'''
blocks is an array of sizes
inter is the inter community probability
intra is the intra community probability
'''
def construct_SBM_block(blocks, inter, intra):
    probs = []
    for i in range(len(blocks)):
        prob = [inter]*len(blocks)
        prob[i] = intra
        probs.append(prob)
    return probs

#n=500

 
################ regualar network ##########################
################## 10 block SBM #################################################



###########
#n=m=1000

sizes_0 = [100]*10
inter_prob = 0.02
intra_prob = 0.1

probs_0 = construct_SBM_block(sizes_0, inter_prob, intra_prob)
print(probs_0)

 
wt = [[normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson,normal, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal]]



wtargs = [[dict(loc=5, scale=1), dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4), dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1)]]




G_0 = sbm(n=sizes_0, p=probs_0, wt=wt, wtargs=wtargs)
AG0=np.matrix(G_0)
G0=nx.from_numpy_matrix(AG0)

_ = heatmap(G0)



G_02 = sbm(n=sizes_0, p=probs_0, wt=wt, wtargs=wtargs)
AG02=np.matrix(G_02)
G02=nx.from_numpy_matrix(AG02)


dist_Deltacon = netrd.distance.DeltaCon()
D_Deltacon = dist_Deltacon.dist(G0, G02, exact=True, g=None)
D_Deltacon #  30.249950011064364




# T=60 networks
T=60  # number of Networks

m=1000
A0 = np.empty((m, m*T))



#A0=[]
for i in range(0, T,1):  
    # i=0
  c1=i*m
  c2=m+c1
 
  G_0 = sbm(n=sizes_0, p=probs_0, wt=wt, wtargs=wtargs)

  NSize = len(G_0)
  print(NSize)


  ## Heat map
  #_ = heatmap(G_0, title ='SBM Simulation')
  #_ = heatmap(G_0)


  #G2=nx.Graph(G_0)
  #edges = G2.number_of_edges()
  #print(edges) #
  #nodes2=G2.number_of_nodes()
  #print(nodes2)

  mat = np.matrix(G_0)
  mat.shape
  print(i)
 
  A0[0:m ,c1:c2]=mat  
  #A0[0:500 ,500:1000]=mat  
  #A0[0:500 ,1000:1500]=mat  
  
  
  A0.shape

  #B0=A0[0:500 ,1000:1500]
  #B0.shape
  
  


###################################################################################
################### Anomalies ####################

### 10 block SBM -- but Edge Weights changed ###########
## Anomaly time 8,17,26, 35,46,54


#### Anomaly Type 1 ####
## Anomaly time 8,17,26


sizes_A1 = [100]*10
inter_prob1 = 0.02
intra_prob1 = 0.1




probs_A1 = construct_SBM_block(sizes_A1, inter_prob1, intra_prob1)
print(probs_A1)


wt1 = [[normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, normal, poisson, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson,normal, poisson, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal, poisson],
      [poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, poisson, normal]]


#  Change last 4 bloks edge weights and few others
wtarg1 = [[dict(loc=20, scale=1), dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6), dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1),dict(lam=6)],
          [dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(lam=6),dict(loc=20, scale=1)]]


G_A1 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
  #mat = np.matrix(G_A1)
_ = heatmap(G_A1)



GA01=np.matrix(G_A1)
GA1=nx.from_numpy_matrix(GA01)


dist_Deltacon = netrd.distance.DeltaCon()
D_Deltacon = dist_Deltacon.dist(G0, GA1, exact=True, g=None)
D_Deltacon #  30.360855551681674





G_A11 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
mat11 = np.matrix(G_A11)

G_A12 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
mat12 = np.matrix(G_A12)

G_A13 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
mat13 = np.matrix(G_A13)



## Anomaly time 8,17,26, 35,46,54

## Anomaly time 8,17,26

t1=8
t2=17
t3=26

A0[0:m ,(t1*m-m):t1*m]=mat11
A0[0:m ,(t2*m-m):t2*m]=mat12 
A0[0:m ,(t3*m-m):t3*m]=mat13


#####################################################################

## Anomaly time  35,46,54

G_B11 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
_ = heatmap(G_B11)

mat21 = np.matrix(G_B11)



G_B12 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
mat22 = np.matrix(G_B12)

G_B13 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)
mat23 = np.matrix(G_B13)


t4=35
t5=46
t6=54

A0[0:m ,(t4*m-m):t4*m]=mat21
A0[0:m ,(t5*m-m):t5*m]=mat22 
A0[0:m ,(t6*m-m):t6*m]=mat23




 



A0.shape



##################### Distance measure ################


data = A0
data.shape
#print(data)


n1=data.shape[0]
n2=data.shape[1]

print(n1)
print(n2)




  
##############################################################

m2=m*T-1


D1_Frob=[]
D1_Deltacon=[]
D1_diff=[]
D1_HannMik=[]

for i in range(0, m2,m):  
    #print(i)
    # i=1000 # 0, 300, 600, 900,----
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
    G1=nx.from_numpy_matrix(A1)
     
    G1.number_of_nodes() # number of nodes
    G1.size()            # number of edges
     # print(G1)
     # nx.draw(G1)
    
     
   #-------------------G2---------------------------
    data1=data[0:n1:, (c1+m):(c2+m)]
    data1.shape
    #print(data1)
    
    A2=np.matrix(data1)
    G2=nx.from_numpy_matrix(A2)
    
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
print(D1_diff)
print(D1_HannMik)
    
#mat = np.matrix(VecI)

  


## AAnomaly time 5,11,17,23,28

plt.plot(D1_Frob, linestyle = 'solid')
plt.plot(D1_Deltacon, linestyle = 'solid')

plt.plot(D1_HannMik, linestyle = 'solid')


# convert array into dataframe
D1_Frob1 = pd.DataFrame(D1_Frob)
D1_Deltacon1 = pd.DataFrame(D1_Deltacon)
D1_HannMik = pd.DataFrame(D1_HannMik)
 
# save the dataframe as a csv file

