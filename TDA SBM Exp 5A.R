


nomFile<-read.table("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Regular_Exp5A.csv", header = TRUE, sep = ",")


nomFile<-nomFile[,-1]  # remove first column-- IDs
head(nomFile[1:5,1:4])

# --- Open Matrix
A0 = as.matrix(nomFile) 
dim(A0)


######################################################
# Regular SBM graphs
######################################################

# Parameters
NMat = 50;

affGRAPS <- list()

for (j in 1:NMat) { # j=2
  
  # j=2
  c1=j*500-500+1
  c2=500+c1-1
  
  B0<-A0[0:500 ,c1:c2];dim(B0)
  #A0[0:500 ,501:1000]
  #A0[0:500 ,1001:1500]
  
  affGRAPS[[j]] <- B0
  
  print(j)
}


dim(affGRAPS[[40]]);dim(affGRAPS[[32]])

######################################################
# Computing The maximum weight among all

maxValAll <- max(A0)
maxValAll

######################################################


######################################################
# Events
######################################################
## Event times: 6, 26, 44  


Events<-read.table("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Events_Exp5A.csv", header = TRUE, sep = ",")

Events<-Events[,-1]  # remove first column-- IDs
head(Events[1:5,1:4])

# --- Open Matrix
A1 = as.matrix(Events);dim(A1)
m1=525

# Events time: 6, 26, 44

#A1[0:525 ,1:525]
#A1[0:525 ,526:1050]
#A1[0:525 ,1051:1575]


affGRAPS[[6]]<-A1[0:525 ,1:525]
affGRAPS[[26]]<-A1[0:525 ,526:1050]
affGRAPS[[44]]<-A1[0:525 ,1051:1575]



######################################################
# Anomaly
######################################################
## Anomaly time: 13, 32, 40



Anomaly_ty2<-read.table("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_Anomaly_Exp5A.csv", header = TRUE, sep = ",")

Anomaly_ty2<-Anomaly_ty2[,-1]  # remove first column-- IDs
head(Anomaly_ty2[1:5,1:4])

# --- Open Matrix
A2 = as.matrix(Anomaly_ty2);dim(A2)

#A2[0:525 ,1:525]
#A2[0:525 ,526:1050]
#A2[0:525 ,1051:1575]


affGRAPS[[13]]<-A2[0:525 ,1:525]
affGRAPS[[32]]<-A2[0:525 ,526:1050]
affGRAPS[[40]]<-A2[0:525 ,1051:1575]



affGRAPS[[22]];affGRAPS[[10]]

###########################################################################
#############################################################################################



Max1=c()

for (i in 1:NMat) { # i=2 #25
  
  Max1[i]<-max(affGRAPS[[i]])
  
  print(i)
  
}


maxValAB<-max(Max1)
maxValAB # 



##############################################################
###################  TDA   #################################################

setwd("C:/Users/adey/OneDrive/Stochastic Block Models/Codes/")

betti_0=betti_1=c()
PD =c()
maxVal_A<-maxValAB

for (i in 1:NMat){ # i=1
  
  matWhole<-affGRAPS[[i]]
  
  aux <- matWhole/maxVal_A # normalization
  A2 <- 1 - aux
  diag(A2) <- 0
  
  #summary(as.numeric(A2[A2<1]))
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  #0.0000  1.0000  1.0000  0.9654  1.0000  1.0000 
  #############################################################################################
  
  cap=2# dimension cap
  delta=0.033 # step size for filtration
  filt_len=30 # filtration length.
  d<-dim(A2)[1]
  
  
  # writing data into file M.txt
  cat(d,file='M.txt',append=F,sep = '\n')
  cat(paste(0,delta,filt_len,cap,sep = ' '),file = 'M.txt',append = T,sep = '\n') # threshold: 0, 0.1, 0.2,...,1
  cat(A2,file='M.txt',append = T) 
  
  
  #-------------------------------------------------------------------
  
  system('perseusWin.exe distmat M.txt Moutput')
  betti_data=as.matrix(read.table('Moutput_betti.txt'))
  
  # insert omitted Bettii numbers
  betti_index=setdiff(0:29,betti_data[,1])  
  for (k in betti_index) 
    if (k<length(betti_data[,1])) 
    {
      betti_data=rbind(betti_data[1:k,],betti_data[k,],betti_data[(k+1):length(betti_data[,1]),]);
      betti_index=betti_index+1
    } else
      betti_data=rbind(betti_data[1:k,],betti_data[k,])
  
  
  
  
  betti_0=cbind(betti_0,betti_data[,2])
  betti_1=cbind(betti_1,betti_data[,3])
  
  
  ################################################################################
  #----------------------WD  ---------------------------
  
  # dim=0
  persist_data = as.matrix(read.table('Moutput_0.txt'))
  persist_data[persist_data[,2] == -1, 2] = filt_len + 1
  persist_data = persist_data/(filt_len + 1)
  P = cbind(rep(0, nrow(persist_data)), persist_data)
  
  # dim=1
  if (file.info('Moutput_1.txt')$size>0)
  { 
    persist_data = as.matrix(read.table('Moutput_1.txt', blank.lines.skip = T))
    persist_data[persist_data[,2] == -1, 2] = filt_len + 1
    persist_data = persist_data/(filt_len + 1)
    P = rbind(P, cbind(rep(1, nrow(persist_data)), persist_data))
    
  }
  
  if (file.info('Moutput_2.txt')$size>0)
  { 
    persist_data = as.matrix(read.table('Moutput_2.txt', blank.lines.skip = T))
    persist_data[persist_data[,2] == -1, 2] = filt_len + 1
    persist_data = persist_data/(filt_len + 1)
    P = rbind(P, cbind(rep(2, nrow(persist_data)), persist_data))
    
  }
  
  PD[[i]] <- P
  
  
  
  print(i)
  
  
}

# PD[[50]]

#############################################################################


#write.table(betti_1, "C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/Betti_1_Exp5A.csv", col.names = FALSE, row.names = FALSE, sep = ",")



Betti<-read.table("C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/Betti_1_Exp5A.csv", header = FALSE, sep = ",")
dim(Betti)

head(Betti[1:5,1:4])

plot.ts(Betti[,1],ylim=c(0,3500), xlim=c(),lwd=1, 
        col='black',xaxt="n",
        ylab = expression(beta[1](epsilon)),
        xlab= expression(epsilon),
        panel.first = grid())

for(i in 2:50){
  
  lines(Betti[,i],lty=1,lwd=1,col='black')
  
} 

# Event time: 6, 26, 44
## Anomaly time: 13, 32, 40


 

lines(Betti[,13],xlim=c(10,30),lty=1,lwd=1,col='red')
lines(Betti[,32],xlim=c(10,30),lty=1,lwd=1,col='red')
lines(Betti[,40],xlim=c(10,30),lty=1,lwd=1,col='red')


lines(Betti[,6],xlim=c(10,30),lty=1,lwd=1,col='red')
lines(Betti[,26],xlim=c(10,30),lty=1,lwd=1,col='red')
lines(Betti[,44],xlim=c(10,30),lty=1,lwd=1,col='red')


axis(1, at=c(0, 5, 10, 15, 20,25,30), 
     labels= c("0",  "0.05", "0.1" , "0.15","0.2","0.25","0.3"),
     cex=1.3)



###########################################################################
######################################################################################################




Dim1=c()

for (i in 1:NMat) { # i=2 #25
  
  Dim1[i]<-dim(PD[[i]])[1]
  
  print(i)
  
}


k1<-min(Dim1)
k1 # 


# Event time: 6, 26, 44
## Anomaly time: 13, 32, 40

#------------------------------------------------------------------------------

D1=c()

for (i in 1:NMat) { # i=2 #25
  
  D1=cbind(D1,PD[[i]][1:k1,])
  dim(D1)
  
  
  print(i)
  
}

dim(D1)

head(D1)

#write.table(D1, "C:/Users/adey/OneDrive/Transportation Network/R code/Simulation/Comparison/Data/SBM_PD_Comb_Exp5A.csv", col.names = FALSE, row.names = FALSE, sep = ",")


##################################################################
#############################################################################################
















