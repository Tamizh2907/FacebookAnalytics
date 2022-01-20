
#read all csv file to data frame

data_files_ClusterA = list.files("data/Cluster-A/")  # Identify file names

#data_files_ClusterA # Print file names

data_files_ClusterC = list.files("data/Cluster-C/")  # Identify file names

#data_files_ClusterC # Print file names


#Build data frame with zipped files from Cluster A - database

datasetclusterA = data.frame()

for (value in 1:length(data_files_ClusterA)){
  
  datasetvalue = paste("data/Cluster-A/",data_files_ClusterA[value], sep = "")
  
  datasetclusterAinter = read.table(datasetvalue, header = FALSE, sep = "\t")
  
  datasetclusterA = rbind(datasetclusterA, datasetclusterAinter)
  
}

datasetclusterA = data.frame(datasetclusterA)

#assign column names

colnames(datasetclusterA) = c("timestamp", "packetlength", "anonymizedsourceIP",
                              
                              "anonymizeddestinationIP", "anonymizedsourceL4Port",
                              
                              "anonymizeddestinationL4Port", "IPprotocol", "anonymizedsourcehostprefix",
                              
                              "anonymizeddestinationhostprefix", "anonymizedsourceRack",
                              
                              "anonymizeddestinationRack", "anonymizedsourcePod", "anonymizeddestinationPod",
                              
                              "intercluster", "interdatacenter")


#Build data frame with zipped files from Cluster C - Hadoop Server

datasetclusterC = data.frame()

for (value in 1:length(data_files_ClusterC)){
  
  datasetvalue = paste("data/Cluster-C/",data_files_ClusterC[value], sep = "")
  
  datasetclusterCinter = read.table(datasetvalue, header = FALSE, sep = "\t")
  
  datasetclusterC = rbind(datasetclusterC, datasetclusterCinter)
  
}

datasetclusterC = data.frame(datasetclusterC)


#Assign column names

colnames(datasetclusterC) = c("timestamp", "packetlength", "anonymizedsourceIP",
                              
                              "anonymizeddestinationIP", "anonymizedsourceL4Port",
                              
                              "anonymizeddestinationL4Port", "IPprotocol", "anonymizedsourcehostprefix",
                              
                              "anonymizeddestinationhostprefix", "anonymizedsourceRack",
                              
                              "anonymizeddestinationRack", "anonymizedsourcePod", "anonymizeddestinationPod",
                              
                              "intercluster", "interdatacenter")

rm(datasetclusterAinter)

rm(datasetclusterCinter)


