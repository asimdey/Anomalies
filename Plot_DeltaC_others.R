

library(TDA) 
library(igraph)


#-------------Frobenius distance --------------------
D0<- read.csv("~/D_Frob_UCI.csv", header=T)
head(D0)

D_Frob<-D0$X0



# plot dimension 795 by 525


par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))

plot.ts(D_Frob,col='black',xaxt="no",type='n',xlab='2004',
        ylab="Frobenius distance",
        xlim=c(0,190))

rect(34,50,43,-1.8,col = "gray95")
rect(59,50,70,-1.8,col = "gray95")

grid(lty=1, lwd=1,col=gray(.9))

lines(D_Frob, lwd=2, col="black")


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



text(18,48,expression(paste("Memorial Day")),cex=0.8, col='red')     
#text(12,70,expression(paste("Holiday")),cex=1.0,col='red')     


text(95,45,expression(paste("Spring Final Exam End,")),cex=0.8, col='red') 
text(90,43,expression(paste("Commencement,")),cex=0.8, col='red') 
text(82,41,expression(paste("Break")),cex=0.8, col='red') 




#-------------DeltaCon similarity --------------------

D1<- read.csv("~/D_Deltacon_UCI.csv", header=T)
head(D1)

D_DeltaC<-D1$X0



# plot dimension 795 by 525
par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))

plot.ts(D_DeltaC,col='black',xaxt="no",type='n',xlab='2004',
        ylab="DeltaCon similarity",
        xlim=c(0,190))

rect(34,50,43,-1.8,col = "gray95")
rect(59,50,70,-1.8,col = "gray95")

grid(lty=1, lwd=1,col=gray(.9))

lines(D_DeltaC, lwd=2, col="black")


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



text(18,9,expression(paste("Memorial Day")),cex=0.8, col='red')     
#text(12,70,expression(paste("Holiday")),cex=1.0,col='red')     


text(95,7.5,expression(paste("Spring Final Exam End,")),cex=0.8, col='red') 
text(90,7.2,expression(paste("Commencement,")),cex=0.8, col='red') 
text(82,7.0,expression(paste("Break")),cex=0.8, col='red') 


  

#-------------Ipsen-Mikhailov distances--------------------

D2<- read.csv("~/D_HannMik_UCI.csv", header=T)
head(D2)

D_IM<-D2$X0



# plot dimension 795 by 525

par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))

plot.ts(D_IM,col='black',xaxt="no",type='n',xlab='2004',
        ylab="Ipsen-Mikhailov distances",
        xlim=c(0,190))

rect(34,50,43,-1.8,col = "gray95")
rect(59,50,70,-1.8,col = "gray95")

grid(lty=1, lwd=1,col=gray(.9))

lines(D_IM, lwd=2, col="black")


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



text(22,0.071,expression(paste("Memorial Day")),cex=0.8, col='red')     
#text(12,70,expression(paste("Holiday")),cex=1.0,col='red')     


text(95,0.055,expression(paste("Spring Final Exam End,")),cex=0.8, col='red') 
text(90,0.052,expression(paste("Commencement,")),cex=0.8, col='red') 
text(82,0.049,expression(paste("Break")),cex=0.8, col='red') 



