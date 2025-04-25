# Topological Anomaly Detection for Weighted Dynamic Networks
## UCI message dataset analysis
The University of California, Irvine (UCI) online community message dataset captures daily user interactions of UCI students from April 19, 2004, to October 26, 2004. The dataset is obtained from the Stanford Network Analysis Project (SNAP).

We construct a weighted dynamic network from the message dataset, generating 190 daily snapshots—one for each day between April 19, 2004, and October 26, 2004. The nodes of each day's network represent the users, and each edge encodes a message interaction from one user to another. The weight of an edge corresponds to the number of characters sent in a message.

The UCI message dataset (UCI_Text_Data_AA.txt) is uploaded as a .zip file. The algorithm has 3 steps: 
1.	First, UCI_Text_TDA1.R is run in R, 
2.	Second, PI_UCI_message.py is run in Python using the output from step 1,
3.	Third, Data_Depth_PI_UCI_message.R is run in R using the output from step 2.

Competitor methods have separate R and Python codes.

