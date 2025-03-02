

library(fdaoutlier)
library(fda.usc)

library(DepthProc)
library(zoo)
library(ineq)


######################################################
###################### Experimet 1 ##################


PI<-read.table("~/Exp4_PI_SBM.csv", header = TRUE, sep = ",")

PI<-PI[,-1]  # remove first column-- IDs
head(PI[1:5,1:4])

dim(PI)


T1=30
T2=T1*3

cc<-seq(1,T2,by=3)
cc



PI_A =c()
#maxVal_A<-maxValAll # maxValAll # 1.999947

for (i in cc){ # i=4
  
  Pi_B<-PI[,i]
  
  PI_A<-cbind(PI_A,Pi_B)
  
  
}


dim(PI_A) # 10000    30

max(PI_A) #  
min(PI_A) # 



############################## Data Depth #############################################


d0<-as.matrix(PI_A);dim(d0)
d0<-t(d0);dim(d0)

## Anomaly time 20,32,40,60,72,92

# Replace NA with 0
#d0[is.na(d0)] <- 0 
#dim(d0)

D0<-extremal_depth(dts = d0) # Depth 

O1<-(1/D0)-1                # Outlyingness
O1

  



O1<-read.table("Outlyingness_Exp4.csv", header = FALSE, sep = ",")
dim(O1)


#######################################################################################################

## Anomaly time 8,17,26

# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))



plot.ts(O1,col='black',ylab=expression(paste("Outlyingness of", ~~PI)),lwd=2,xlab='t',
        xlim=c(0,30),first.pannel=grid())


abline(v=8, col="red",lty=2,lwd=1)
abline(v=17, col="red",lty=2,lwd=1)
abline(v=26, col="red",lty=2,lwd=1)




legend("topleft",title= "Experiment 1",
       c("Anomaly (Ground truth)", "Detected Anomaly"), 
       lwd = 1, lty = 2,col = c('red'), cex=1.0)




###### Threshold ####################
## Anomaly time 8,17,26

#hist(O1,breaks=50)
Od1<-cbind(1:length(O1),O1)
qa1<-quantile(O1,c(0.95));qa1 # Qa is the threshold
Od1[Od1[,2]>qa1,]

#[1,] 20 99.00000
#[2,] 40 32.33333
#[3,] 60 15.66667
#[4,] 72 49.00000
#[5,] 92 24.00000

#c1<-1.5*(IQR(O1)) # For symmetric
#Od1[Od1[,2]>c1,]

#MAD<-mad(O1) ## Highly skewed
#c2<-3*1.482*MAD 
#Od1[Od1[,2]>c2,]



#######################################################
TP= 5          # TRUE POSITIVE (TP)
FN= 1          #  False negative (FN) 
FP= 0         # FALSE POSITIVE (FP)
Precision= TP/(TP+FP);Precision # 1

# sensitivity, recall, hit rate, or true positive rate (TPR)
# That is, fraction of true changes successfully detected 
Recall=TP/(TP+FN);Recall  # 0.8333333
# F1--- combines precision and recall
F1= 2*((Precision*Recall)/(Precision+Recall));F1 # 0.9090909

















