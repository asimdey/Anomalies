

library(igraph)
######################################################
###################### Experimet 1 ##################

nomFile<-read.table("SBM_Cobmined_RegularAnomaly_Exp2A.csv", header = TRUE, sep = ",")


nomFile<-nomFile[,-1]  # remove first column-- IDs
head(nomFile[1:5,1:4])

# --- Open Matrix
A0 = as.matrix(nomFile) 
dim(A0)


######################################################
# Regular and anomaly SBM graphs
######################################################

# Parameters
NMat = 60;
m=500

affGRAPS <- list()
GG<-list()
for (j in 1:NMat) { # j=2
  
  # j=2
  c1=j*m-m+1
  c2=m+c1-1
  
  B0<-A0[0:m ,c1:c2];dim(B0)
  #A0[0:m ,501:1000]
  
  
  affGRAPS[[j]] <- B0
 
  GG[[j]]<-graph_from_adjacency_matrix(B0, weighted=TRUE, mode ="undirected")
  
  print(j)
}




#----------- Weights--------------
E(GG[[1]])$weight

V(GG[[1]])

g  <- graph.adjacency(affGRAPS[[2]],weighted=TRUE)
df <- get.data.frame(g)
head(df)

#plot(GG[[2]], layout=layout_with_fr, vertex.size=2,vertex.label=NA)


############ SCAN Statistics ############

SS1<-scan_stat(graphs = GG, k = 1, tau = 2, ell = 2)
SS<-SS1$stat
SS[is.na(SS)] <- 0



plot.ts(abs(SS),first.panel=grid())
abline(v=8, col="red",lty=2,lwd=1)
abline(v=17, col="red",lty=2,lwd=1)
abline(v=26, col="red",lty=2,lwd=1)

abline(v=35, col="red",lty=2,lwd=1)
abline(v=46, col="red",lty=2,lwd=1)
abline(v=54, col="red",lty=2,lwd=1)





## For symmetric

Od1<-cbind(1:length(SS),abs(SS))
qa1<-quantile(abs(SS),c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]

#[1,]    8 18.50
#[2,]   16  7.25
#[3,]   55 21.50


## Anomaly time 8, 17, 26, 35,46,54

#######################################################
TP= 1          # TRUE POSITIVE (TP)
FN= 5          #  False negative (FN) 
FP= 2         # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.333

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 0.166
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #  0.222









#######################################################################################
################## Experiment 2 ###########################


nomFile<-read.table("SBM_Cobmined_RegularAnomaly_Exp4B.csv", header = TRUE, sep = ",")


nomFile<-nomFile[,-1]  # remove first column-- IDs
head(nomFile[1:15,1:14])

# --- Open Matrix
A0 = as.matrix(nomFile) 
dim(A0)


######################################################
# Regular and anomaly SBM graphs
######################################################

# Parameters
NMat = 60 # Number of Networks
m=1000

affGRAPS <- list()
GG_2<- list()
for (j in 1:NMat) { # j=2
  
  # j=2
  c1=j*m-m+1
  c2=m+c1-1
  
  B0<-A0[0:m ,c1:c2];dim(B0)
  #A0[0:m ,1001:2000]
  #A0[0:m ,2001:3000]
  
  affGRAPS[[j]] <- B0
  GG_2[[j]]<-graph_from_adjacency_matrix(B0, weighted=TRUE, mode ="undirected")
  
  
  
  print(j)
}


dim(affGRAPS[[30]]);dim(affGRAPS[[3]])


############ SCAN Statistics ############

SS_3<-scan_stat(graphs = GG_2, k = 1, tau = 4, ell = 2)
SS_B<-SS_3$stat
SS_B[is.na(SS_B)] <- 0


## Anomaly time 8, 17, 26, 35,46,54
plot.ts(abs(SS_B),first.panel=grid())
abline(v=8, col="red",lty=2,lwd=1)
abline(v=17, col="red",lty=2,lwd=1)
abline(v=26, col="red",lty=2,lwd=1)

abline(v=35, col="red",lty=2,lwd=1)
abline(v=46, col="red",lty=2,lwd=1)
abline(v=54, col="red",lty=2,lwd=1)





## For symmetric


Od1<-cbind(1:length(SS_B),abs(SS_B))
qa1<-quantile(abs(SS_B),c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]



#[1,]   17 11.75266
#[2,]   24 16.75501
#[3,]   35 12.12633

## Anomaly time 8, 17, 26, 35,46,54
#######################################################
TP= 2          # TRUE POSITIVE (TP)
FN= 4          #  False negative (FN) 
FP= 1        # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.667

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 0.3333
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #  0.444









