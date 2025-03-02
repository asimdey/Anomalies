

library(fdaoutlier)
library(fda.usc)

library(DepthProc)
library(zoo)
library(ineq)


######################################################
###################### Experimet 2 ##################


PI<-read.table("~Exp4B_PI_SBM.csv", header = TRUE, sep = ",")

PI<-PI[,-1]  # remove first column-- IDs
head(PI[1:5,1:4])

dim(PI)


T1=60
T2=T1*3

cc<-seq(1,T2,by=3)
cc



PI_A =c()
#maxVal_A<-maxValAll # maxValAll # 1.999947

for (i in cc){ # i=4
  
  Pi_B<-PI[,i]
  
  PI_A<-cbind(PI_A,Pi_B)
  
  
}


dim(PI_A) # 10000    60

max(PI_A) #  
min(PI_A) # 



############################## Data Depth #############################################


d0<-as.matrix(PI_A);dim(d0)
d0<-t(d0);dim(d0)

## Anomaly time 8, 17, 26, 35,46,54

# Replace NA with 0
#d0[is.na(d0)] <- 0 
#dim(d0)

D0<-extremal_depth(dts = d0) # Depth 

O1<-(1/D0)-1                # Outlyingness
O1





O1<-read.table("Outlyingness_Exp4B.csv", header = FALSE, sep = ",")
dim(O1)

O1<-O1$V1

#######################################################################################################

## Anomaly time 8, 17, 26, 35,46,54

# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))



plot.ts(O1,col='black',ylab=expression(paste("Outlyingness of", ~~PI)),lwd=2,xlab='t',
        xlim=c(0,60),first.pannel=grid())


abline(v=8, col="red",lty=2,lwd=1)
abline(v=17, col="red",lty=2,lwd=1)
abline(v=26, col="red",lty=2,lwd=1)

abline(v=35, col="red",lty=2,lwd=1)
abline(v=46, col="red",lty=2,lwd=1)
abline(v=54, col="red",lty=2,lwd=1)


legend("topleft",title= "Experiment 2",
       c("Anomaly (Ground truth)", "Detected Anomaly"), 
       lwd = 1, lty = 2,col = c('red'), cex=1.0)


  

###### Threshold ####################

## Anomaly time 8, 17, 26, 35,46,54

#hist(O1,breaks=50)


## For symmetric
Od1<-cbind(1:length(O1),O1)
qa1<-quantile(O1,c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]


#c1<-1.5*(IQR(O1)) # For symmetric
#Od1[Od1[,2]>c1,]


## For skewed
MAD<-mad(O1)
c2<-3*1.482*MAD 
Od1[Od1[,2]>c2,]
  

#  8 14.000000
# 17 19.000000
# 26  7.571429
# 32  6.500000
# 35  9.000000
# 46 59.000000
# 48 11.000000
# 54 29.000000


## Anomaly time 8, 17, 26, 35,46,54

#######################################################
TP= 6          # TRUE POSITIVE (TP)
FN= 0          #  False negative (FN) 
FP= 2        # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.75

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 1.0
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #  0.8571429








############### Comparisons with state of art methods #########################

## 1. Deltacon ###################

## Anomaly time 7, 16, 25, 34,45,53
# here we need to back one because it losses first distance



D1<-read.table("~/D_Deltacon_SBM_exp4B.csv", header = FALSE, sep = ",")
dim(D1)
head(D1)

D1<-D1$V2[-1]

# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))


plot.ts(D1,col='black',ylab="",lwd=2,xlab='t',
        xlim=c(0,60),first.pannel=grid())


abline(v=7, col="red",lty=2,lwd=1)
abline(v=16, col="red",lty=2,lwd=1)
abline(v=25, col="red",lty=2,lwd=1)

abline(v=34, col="red",lty=2,lwd=1)
abline(v=45, col="red",lty=2,lwd=1)
abline(v=53, col="red",lty=2,lwd=1)


legend("topleft",title= "Experiment 2",
       c("Anomaly (Ground truth)", "Detected Anomaly"), 
       lwd = 1, lty = 2,col = c('red'), cex=1.0)







#hist(D1,breaks=10)

## Anomaly time 7, 16, 25, 34,45,53
# here we need to back one because it losses first distance

## For symmetric
Od1<-cbind(1:length(D1),D1)
qa1<-quantile(D1,c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]

#  9 31.36254
# 32 30.80461
# 33 30.84019


#######################################################
TP= 0          # TRUE POSITIVE (TP)
FN= 6          #  False negative (FN) 
FP= 3        # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.000

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 0.000
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #  Nan





## 2. Frobenius distance  ###################


F2<-read.table("D_Frob_SBM_exp4B.csv", header = FALSE, sep = ",")
dim(F2)
head(F2)

F2<-F2$V2[-1]

# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))


plot.ts(F2,col='black',ylab="",lwd=2,xlab='t',
        xlim=c(0,60),first.pannel=grid())


abline(v=7, col="red",lty=2,lwd=1)
abline(v=16, col="red",lty=2,lwd=1)
abline(v=25, col="red",lty=2,lwd=1)

abline(v=34, col="red",lty=2,lwd=1)
abline(v=45, col="red",lty=2,lwd=1)
abline(v=53, col="red",lty=2,lwd=1)


legend("bottomleft",title= "Experiment 2",
       c("Anomaly (Ground truth)", "Detected Anomaly"), 
       lwd = 1, lty = 2,col = c('red'), cex=1.0)







#hist(F1,breaks=10)

## Anomaly time 7, 16, 25, 34,45,53
# here we need to back one because it losses first distance

## For symmetric
Od1<-cbind(1:length(F2),F2)
qa1<-quantile(F2,c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]

# 13 229.9043
# 25 229.8782
# 54 230.2216



#######################################################
TP= 1          # TRUE POSITIVE (TP)
FN= 5         #  False negative (FN) 
FP= 2        # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.3333333

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  #  0.1666667
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #  0.2222222







## 3. Combination of Hamming and Ipsen-Mikhailov distances  ###################


IM1<-read.table("D_HannMik_SBM_exp4B.csv", header = FALSE, sep = ",")
dim(IM1)
head(IM1)




IM1<-IM1$V2[-1]


## Anomaly time 7, 16, 25, 34,45,53
# here we need to back one because it losses first distance


# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))


plot.ts(IM1,col='black',ylab="",lwd=2,xlab='t',
        xlim=c(0,60),first.pannel=grid())


abline(v=7, col="red",lty=2,lwd=1)
abline(v=16, col="red",lty=2,lwd=1)
abline(v=25, col="red",lty=2,lwd=1)

abline(v=34, col="red",lty=2,lwd=1)
abline(v=45, col="red",lty=2,lwd=1)
abline(v=53, col="red",lty=2,lwd=1)


legend("bottomleft",title= "Experiment 2",
       c("Anomaly (Ground truth)", "Detected Anomaly"), 
       lwd = 1, lty = 2,col = c('red'), cex=1.0)







#hist(IM1)

## Anomaly time 7, 16, 25, 34,45,53
# here we need to back one because it losses first distance

## For symmetric
Od1<-cbind(1:length(IM1),IM1)
qa1<-quantile(IM1,c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]

# 39 0.04020365
# 45 0.04157107
# 53 0.04065728

  

#######################################################
TP= 2          # TRUE POSITIVE (TP)
FN= 4          #  False negative (FN) 
FP= 1        # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 0.666

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 0.333
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 #   0.444















