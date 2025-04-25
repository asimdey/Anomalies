

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
  
  #GG[[j]]<-G2
  
  M1<-as_adjacency_matrix(G2)
  # dim(M1)
  
  
  ## Combined Adjacency matrices
  AD1<-cbind(AD1,M1)
  #dim(AD1)
  
  #N1<-c(N1,length(V(G1)))
  

  
  
}



## max of nodes in all 15 networks.
## max(N1) # 1899

AD2<-as.matrix(AD1)
# write.table(AD2,"~/Adj_Comb_UCI_BV2.csv", col.names = FALSE, row.names = FALSE, sep = ",")









