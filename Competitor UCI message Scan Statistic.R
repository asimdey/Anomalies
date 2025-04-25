

library(TDA) 
library(igraph)



D0<- read.table("~/UCI_Text_Data_AA.txt", quote="\"", comment.char="")
head(D0)

names(D0)<-c("Date0", "From", "To","Weight")
head(D0)
dim(D0) 

D0$Date <- format(as.POSIXct(D0$Date0,format = "%Y-%m-%d %H:%M:%S"),
                  format = '%m/%d/%Y')
head(D0)



Date0<-unique(D0$Date);Date0[1]
B<-length(Date0);B # 190 # Number of networks


# Check dim of dataset for each day
Dim_day =c()
for (i in 1:B){ #j=69
  
  DD<-D0[D0$Date==Date0[i],]  #names(DD)
  dim(DD)
  
  Dim_day[i]<-dim(DD)[1] 
}



################################################################################
GG<-list()
N1<-c()

AD1<-c()


for (j in 1:B){ #j=70
  
  
  
  ############################## Network in each day ############################################
  
  
  DD<-D0[D0$Date==Date0[j],]  #names(DD)
  dim(DD)
  
  
  ## Network from edgelist 
  D1<-DD[,c(2,3)] #D1 # Edge list
  D_edge=data.matrix(D1)
  G1=graph_from_edgelist(D_edge,directed = F)
  
  node<-V(G1);length(node) #  
  edge<-E(G1);length(edge) #  
  
  #plot(G1, layout=layout_with_fr, vertex.size=2,vertex.label=NA)
  
  
  ## Weight and  Normalization
  weight1<-DD[,c(4)] # Weight # 
  #weight1[weight1==0]<-0.001  # Replacing zeros with a very samll number
  
  W2<- (weight1-min(weight1))/(max(weight1)-min(weight1))
  
  D_edge=data.matrix(D1);dim(D_edge)
  G1=graph_from_edgelist(D_edge,directed = F) 
  
  E(G1)$weight<-W2
  
  node<-V(G1);length(node) #  
  NR<-(1899 - length(node))
  G2<-G1%>%add_vertices(NR)
  length(V(G2))  
  
  GG[[j]]<-G2
  

  
 #  N1<-c(N1,length(V(G1)))
  
  
}



## max of nodes in all 15 networks.
## max(N1) # 1899


############ SCAN Statistics ############

#GG<-GG[-1] 

SS1<-scan_stat(graphs = GG, k = 1, tau = 2, ell = 2)
SS<-SS1$stat
SS[is.na(SS)] <- 0



plot.ts(abs(SS))




par(mfrow = c(1,1), mar = c(5.1,5,1.5,2.1))

plot.ts(abs(SS),col='black',xaxt="no",type='n',xlab='2004',
        ylab="Scan statistics",
        xlim=c(0,190))



rect(34,60,43,-1.8,col = "gray95")



rect(59,60,70,-1.8,col = "gray95")
grid(lty=1, lwd=1,col=gray(.9))


lines(abs(SS), lwd=2, col="black")


axis(1, at=c(13, 44, 73, 104,135,165), 
     labels= c( "May", "June" , "July","August","September","October"),
     cex=1.3)



text(18,45,expression(paste("Memorial Day")),cex=0.8, col='red')     
#text(12,70,expression(paste("Holiday")),cex=1.0,col='red')     


text(95,45,expression(paste("Spring Final Exam End,")),cex=0.8, col='red') 
text(90,42,expression(paste("Commencement,")),cex=0.8, col='red') 
text(80,39,expression(paste("Break")),cex=0.8, col='red') 



  