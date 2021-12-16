#read all csv file to data frame

data_files_ClusterA = list.files("data/Cluster-A/")  # Identify file names

#data_files_ClusterA # Print file names

data_files_ClusterC = list.files("data/Cluster-C/")  # Identify file names

#data_files_ClusterC # Print file names


#Build data frame with zipped files from Cluster A - database

for (value in 1:20){
  
  datasetvalue = paste("data/Cluster-A/",data_files_ClusterA[value], sep = "")
  
  datasetclusterA = read.table(datasetvalue, header = FALSE, sep = "\t")
  
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

for (value in 1:20){
  
  datasetvalue = paste("data/Cluster-C/",data_files_ClusterC[value], sep = "")
  
  datasetclusterC = read.table(datasetvalue, header = FALSE, sep = "\t")
  
}

datasetclusterC = data.frame(datasetclusterC)


#Assign column names

colnames(datasetclusterC) = c("timestamp", "packetlength", "anonymizedsourceIP",
                              
                              "anonymizeddestinationIP", "anonymizedsourceL4Port",
                              
                              "anonymizeddestinationL4Port", "IPprotocol", "anonymizedsourcehostprefix",
                              
                              "anonymizeddestinationhostprefix", "anonymizedsourceRack",
                              
                              "anonymizeddestinationRack", "anonymizedsourcePod", "anonymizeddestinationPod",
                              
                              "intercluster", "interdatacenter")

#Remove duplicate values

datasetclusterA = datasetclusterA %>% distinct()

datasetclusterC = datasetclusterC %>% distinct()

#Sort with time stamp

datasetclusterAsorted = datasetclusterA[order(datasetclusterA$timestamp),]

datasetclusterCsorted = datasetclusterC[order(datasetclusterC$timestamp),]

#filter values to ease analysis

datasetclusterAfilter = datasetclusterAsorted %>%
  
  filter((nchar(anonymizedsourceIP) == 16) & (nchar(anonymizeddestinationIP) == 16) &
           
           (nchar(anonymizedsourceL4Port) == 8) & (nchar(anonymizeddestinationL4Port) == 8) &
           
           (nchar(anonymizedsourcehostprefix) == 8) & (nchar(anonymizeddestinationhostprefix) == 8) &
           
           (nchar(anonymizedsourceRack) == 8) & (nchar(anonymizeddestinationRack) == 8) &
           
           (nchar(anonymizedsourcePod) == 8) & (nchar(anonymizeddestinationPod) == 8) &
           
           (nchar(intercluster) == 1) & (nchar(interdatacenter) == 1))

datasetclusterCfilter = datasetclusterCsorted %>%
  
  filter((nchar(anonymizedsourceIP) == 16) & (nchar(anonymizeddestinationIP) == 16) &
           
           (nchar(anonymizedsourceL4Port) == 8) & (nchar(anonymizeddestinationL4Port) == 8) &
           
           (nchar(anonymizedsourcehostprefix) == 8) & (nchar(anonymizeddestinationhostprefix) == 8) &
           
           (nchar(anonymizedsourceRack) == 8) & (nchar(anonymizeddestinationRack) == 8) &
           
           (nchar(anonymizedsourcePod) == 8) & (nchar(anonymizeddestinationPod) == 8) &
           
           (nchar(intercluster) == 1) & (nchar(interdatacenter) == 1))



#Change time stamp to human readable date

datasetclusterAfilter$timestamp = as.POSIXct(datasetclusterAfilter$timestamp, origin = "1970-01-01")

datasetclusterCfilter$timestamp = as.POSIXct(datasetclusterCfilter$timestamp, origin = "1970-01-01")
