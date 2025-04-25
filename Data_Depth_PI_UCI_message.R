

library(fdaoutlier)
library(fda.usc)

library(DepthProc)
library(zoo)
library(ineq)

 
######################################################
###################### Experimet 2 ##################


PI<-read.table("~/UCI_message_PI.csv", header = TRUE, sep = ",")

PI<-PI[,-1]  # remove first column-- IDs
head(PI[1:5,1:4])

dim(PI)

#T1=190  # Number of Networks 
T1=190
T2=T1*3

cc<-seq(1,T2,by=3)
cc



PI_A =c()
#maxVal_A<-maxValAll # maxValAll # 1.999947

for (i in cc){ # i=4
  
  Pi_B<-PI[,i]
  
  PI_A<-cbind(PI_A,Pi_B)
  
  
}


dim(PI_A) # 250000     68

max(PI_A) #  
min(PI_A) # 



############################## Data Depth #############################################


d0<-as.matrix(PI_A);dim(d0)
d0<-t(d0);dim(d0)

## Anomaly time 8, 17, 26, 35,46,54



D0<-extremal_depth(dts = d0) # Depth 

O1<-(1/D0)-1                # Outlyingness
O1

O1[6]<-O1[5]


#write.table(O1, "~/Outlyingness_UCI_message.csv", col.names = FALSE, row.names = FALSE, sep = ",")



O1<-read.table("~/Outlyingness_UCI_message.csv", header = FALSE, sep = ",")
dim(O1)

O1<-O1$V1

#######################################################################################################


# Figure Dimension: Width-700, Height-485
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))



plot.ts(O1,col='black',xaxt="no",xlab='2004',
        ylab=expression(paste("Outlyingness of", ~~PI)),lwd=2,
        xlim=c(0,190),first.pannel=grid())


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



##########################################################################

  

par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))

plot.ts(O1,col='black',xaxt="no",type='n',xlab='2004',
        ylab=expression(paste("Outlyingness of", ~~PI)),
        xlim=c(0,190))



rect(34,96,43,-1.8,col = "gray95")



rect(59,96,70,-1.8,col = "gray95")
grid(lty=1, lwd=1,col=gray(.9))


lines(O1, lwd=2, col="black")


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



text(18,75,expression(paste("Memorial Day")),cex=0.8, col='red')     
#text(12,70,expression(paste("Holiday")),cex=1.0,col='red')     


text(95,60,expression(paste("Spring Final Exam End,")),cex=0.8, col='red') 
text(90,55,expression(paste("Commencement,")),cex=0.8, col='red') 
text(80,50,expression(paste("Break")),cex=0.8, col='red') 










































