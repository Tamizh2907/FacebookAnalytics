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

#Classify into intra-cluster, inter-cluster, intra-data-center, inter-data-center

datasetClusterAtimestamptraffic = datasetclusterAfilter

datasetClusterAtimestamptraffic$clusterdatacenter = 
  
  paste(datasetclusterAfilter$intercluster, datasetclusterAfilter$interdatacenter, sep = "")

datasetclusterAbothintra = datasetclusterAfilter %>%
  
  filter(intercluster == "0" & interdatacenter == "0")

datasetclusterAintercluster = datasetclusterAfilter %>%
  
  filter(intercluster == "1" & interdatacenter == "0")

datasetclusterAinterdatacenter = datasetclusterAfilter %>%
  
  filter(intercluster == "1" & interdatacenter == "1")



datasetClusterCtimestamptraffic = datasetclusterCfilter

datasetClusterCtimestamptraffic$clusterdatacenter = 
  
  paste(datasetclusterCfilter$intercluster, datasetclusterCfilter$interdatacenter, sep = "")

datasetclusterCbothintra = datasetclusterCfilter %>%
  
  filter(intercluster == "0" & interdatacenter == "0")

datasetclusterCintercluster = datasetclusterCfilter %>%
  
  filter(intercluster == "1" & interdatacenter == "0")

datasetclusterCinterdatacenter = datasetclusterCfilter %>%
  
  filter(intercluster == "1" & interdatacenter == "1")



#Pattern finding in traffic - source and destination pairs


datasetclusterAIPpairing = datasetclusterAfilter %>%
  
  count(anonymizedsourceIP, anonymizeddestinationIP, sort = TRUE)

datasetclusterCIPpairing = datasetclusterCfilter %>%
  
  count(anonymizedsourceIP, anonymizeddestinationIP, sort = TRUE)


