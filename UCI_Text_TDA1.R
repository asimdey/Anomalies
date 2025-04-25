

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

setwd("~/R code/")


betti_0=betti_1=c()
PD =c()
  

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
  
  
  
  E(G1)$weight <-W2
  summary(E(G1)$weight)
  
  
  
  #============================= TDA ===================================================
  
  
  A1<- get.adjacency(G1,attr="weight")
  A2<-as.matrix(A1)
  A2[A2==0]<-999
  diag(A2)=0
  
  
  cap=2# dimension cap
  delta=0.033 # step size for filtration
  filt_len=30 # filtration length.
  d<-length(V(G1))
  
  
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
  
  PD[[j]] <- P
  
  
  
  print(j)
  
  
  
}


dim(PD[[24]])









dim(betti_1)

######################################################################
################# Betti sequence ######################################

#write.table(betti_1, "~/Betti_1_UCI_message.csv", col.names = FALSE, row.names = FALSE, sep = ",")


Betti<-read.table("~/Betti_1_UCI_message.csv", header = FALSE, sep = ",")
dim(Betti)


NMat<-B # Number of Networks

head(Betti[1:5,1:4])




plot.ts(Betti[,1],xlim=c(),ylim=c(0,300),lwd=1, 
        col='black',xaxt="n",
        ylab = expression(beta[1](epsilon)),
        xlab= expression(epsilon),
        panel.first = grid())

for(i in 2:190){
  
  lines(Betti[,i],lty=1,lwd=1,col='black')
  
} 




axis(1, at=c(0, 5, 10, 15, 20,25,30), 
     labels= c(),
     cex=1.3)


legend("topleft",title="Experiment 1",
       c("Regular network", "Anomaly" ), 
       lwd = 1, lty = 1,col = c('black', 'red'), cex=0.9)







###########################################################################
######################################################################################################




#NMat<-B


Dim1=c()

for (i in 1:NMat) { # i=2 #25
  
  Dim1[i]<-dim(PD[[i]])[1]
  
  print(i)
  
}


k1<-min(Dim1)
k1








#------------------------------------------------------------------------------

D1=c()

for (i in 1:NMat) { # i=1 #25
  
  D1=cbind(D1,PD[[i]][1:k1,])
  dim(D1)
  
  
  print(i)
  
}

dim(D1)

head(D1)

#write.table(D1, "~/PD_Comb_UCI_message.csv", col.names = FALSE, row.names = FALSE, sep = ",")



##################################################################
#############################################################################################











