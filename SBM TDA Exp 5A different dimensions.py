
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
################## 5 block SBM #################################################

sizes_0 = [100]*5 # size --block sizes

inter_prob = 0.02
intra_prob = 0.1




probs_0 = construct_SBM_block(sizes_0, inter_prob, intra_prob)
print(probs_0)



wt = [[normal, poisson, poisson, poisson,poisson],
      [poisson, normal, poisson, poisson,poisson],
      [poisson, poisson, normal, poisson,poisson],
      [poisson, poisson, poisson, normal,poisson],
      [poisson, poisson, poisson, poisson,normal]]


wtargs = [[dict(loc=5, scale=1), dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4), dict(loc=5, scale=1),dict(lam=4),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1),dict(lam=4)],
          [dict(lam=4),dict(lam=4),dict(lam=4),dict(lam=4),dict(loc=5, scale=1)]]


G_0 = sbm(n=sizes_0, p=probs_0, wt=wt, wtargs=wtargs)
AG0=np.matrix(G_0)
G0=nx.from_numpy_matrix(AG0)
_ = heatmap(G0)

G_02 = sbm(n=sizes_0, p=probs_0, wt=wt, wtargs=wtargs)
AG02=np.matrix(G_02)
G02=nx.from_numpy_matrix(AG02)


dist_Deltacon = netrd.distance.DeltaCon()
D_Deltacon = dist_Deltacon.dist(G0, G02, exact=True, g=None)
D_Deltacon #  20.92255901135936


##   Frobenius distance #############
dist_Frob = netrd.distance.Frobenius()
D_Frob = dist_Frob.dist(G0, G02)
D_Frob


## Hamming and Ipsen-Mikhailov distances ###########
dist_HannMik = netrd.distance.HammingIpsenMikhailov()
D_HannMik = dist_HannMik.dist(G0, G02, combination_factor=1)
D_HannMik

#############################################################################################
############# different dim --number of nides are different ###


sizes_A1 = [105]*5 # size --block sizes
inter_prob = 0.02
intra_prob = 0.1

probs_A1 = construct_SBM_block(sizes_A1, inter_prob, intra_prob)
print(probs_A1)



G_B1 = sbm(n=sizes_A1, p=probs_A1, wt=wt, wtargs=wtargs)
BG1=np.matrix(G_B1)
GB1=nx.from_numpy_matrix(BG1)

_ = heatmap(GB1)


dist_Deltacon = netrd.distance.DeltaCon()
D_Deltacon = dist_Deltacon.dist(G0, GB1, exact=True, g=None)
D_Deltacon #  20.92255901135936


dist_Frob = netrd.distance.Frobenius()
D_Frob = dist_Frob.dist(G0, GB1)
D_Frob


dist_HannMik = netrd.distance.HammingIpsenMikhailov()
D_HannMik = dist_HannMik.dist(G0, GB1, combination_factor=1)
D_HannMik










#######################################################################################
############################################################################################

sizes_0 = [100]*5 # size --block sizes

inter_prob = 0.02
intra_prob = 0.1

probs_0 = construct_SBM_block(sizes_0, inter_prob, intra_prob)
print(probs_0)

# T=60 networks
T=50

m=500
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
  
  
  # convert array into dataframe
  AD = pd.DataFrame(A0)
  # save the dataframe as a csv file
  AD.to_csv("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Regular_Exp5A.csv")


###################################################################################

## 3 Event--- only small change in dim, i.e., number of nodes

sizes_A1 = [105]*5 # size --block sizes
inter_prob = 0.02
intra_prob = 0.1

probs_A1 = construct_SBM_block(sizes_A1, inter_prob, intra_prob)
print(probs_A1)

m1=525
A1 = np.empty((m1, m1*3))

#A0=[]
for i in range(0, 3,1):  
  # i=2
  c1=i*m1
  c2=m1+c1
 
  G_A1 = sbm(n=sizes_A1, p=probs_A1, wt=wt, wtargs=wtargs)

  #_ = heatmap(G_A1, title='Weighted SBM Simulation')
  #_ = heatmap(G_A1)


  #G2=nx.Graph(G_A1)
  #edges = G2.number_of_edges()
  #print(edges) #
  #nodes2=G2.number_of_nodes()
  #print(nodes2)

  mat = np.matrix(G_A1)
  mat.shape
  print(i)
 
  A1[0:m1 ,c1:c2]=mat  
  #A0[0:500 ,500:1000]=mat  
  #A0[0:500 ,1000:1500]=mat  
  
  A1.shape

  # convert array into dataframe
  AD1 = pd.DataFrame(A1)
  # save the dataframe as a csv file
  AD1.to_csv("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Events_Exp5A.csv")




##############################################################################################################
################### 3 Anomalies -- edge weight changed ####################
sizes_A1 = [105]*5 # size --block sizes
inter_prob = 0.02
intra_prob = 0.1

probs_A1 = construct_SBM_block(sizes_A1, inter_prob, intra_prob)
print(probs_A1)



 
wt1 = [[normal, poisson, poisson, poisson,poisson],
      [poisson, normal, poisson, poisson,poisson],
      [poisson, poisson, normal, poisson,poisson],
      [poisson, poisson, poisson, normal,poisson],
      [poisson, poisson, poisson, poisson,normal]]


wtarg1 = [[dict(loc=15, scale=1), dict(lam=7),dict(lam=7),dict(lam=7),dict(lam=7)],
          [dict(lam=7), dict(loc=15, scale=1),dict(lam=7),dict(lam=7),dict(lam=7)],
          [dict(lam=7),dict(lam=7),dict(loc=15, scale=1),dict(lam=7),dict(lam=7)],
          [dict(lam=7),dict(lam=7),dict(lam=7),dict(loc=15, scale=1),dict(lam=7)],
          [dict(lam=7),dict(lam=7),dict(lam=7),dict(lam=7),dict(loc=15, scale=1)]]

  
m1=525
A2 = np.empty((m1, m1*3))

 
for i in range(0, 3,1):  
  # i=2
  c1=i*m1
  c2=m1+c1
 
  G_A1 = sbm(n=sizes_A1, p=probs_A1, wt=wt1, wtargs=wtarg1)

  #_ = heatmap(G_A1, title='Weighted SBM Simulation')
  #_ = heatmap(G_A1)

  
  #G2=nx.Graph(G_A1)
  #edges = G2.number_of_edges()
  #print(edges) #
  #nodes2=G2.number_of_nodes()
  #print(nodes2)

  mat = np.matrix(G_A1)
  mat.shape
  print(i)
 
  A2[0:m1 ,c1:c2]=mat  
  #A0[0:500 ,500:1000]=mat  
  #A0[0:500 ,1000:1500]=mat  
  
  A2.shape

  # convert array into dataframe
  AD2 = pd.DataFrame(A2)
  # save the dataframe as a csv file
  AD2.to_csv("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Anomaly_Exp5A.csv")
  
  