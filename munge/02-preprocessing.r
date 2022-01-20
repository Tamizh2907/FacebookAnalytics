#Remove duplicate values

datasetclusterA = datasetclusterA %>% distinct()

datasetclusterC = datasetclusterC %>% distinct()

#Sort with time stamp

datasetclusterAsorted = datasetclusterA[order(datasetclusterA$timestamp),]

datasetclusterCsorted = datasetclusterC[order(datasetclusterC$timestamp),]

rm(datasetclusterA)

rm(datasetclusterC)

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


rm(datasetclusterAsorted)

rm(datasetclusterCsorted)

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


#Identifying traffic of different clusters
  
datasetclusterAfilterwithClustername = datasetclusterAfilter 

datasetclusterAfilterwithClustername['clustername'] = 'Database'

datasetclusterCfilterwithClustername = datasetclusterCfilter 

datasetclusterCfilterwithClustername['clustername'] = 'Hadoop server'


rm(datasetclusterAfilter)

rm(datasetclusterCfilter)


datasetclusterAwithClusternamebothintra = datasetclusterAfilterwithClustername %>%
  
  filter(intercluster == "0" & interdatacenter == "0")

datasetclusterAwithClusternameintercluster = datasetclusterAfilterwithClustername %>%
  
  filter(intercluster == "1" & interdatacenter == "0")

datasetclusterAwithClusternameinterdatacenter = datasetclusterAfilterwithClustername %>%
  
  filter(intercluster == "1" & interdatacenter == "1")


datasetclusterCwithClusternamebothintra = datasetclusterCfilterwithClustername %>%
  
  filter(intercluster == "0" & interdatacenter == "0")

datasetclusterCwithClusternameintercluster = datasetclusterCfilterwithClustername %>%
  
  filter(intercluster == "1" & interdatacenter == "0")

datasetclusterCwithClusternameinterdatacenter = datasetclusterCfilterwithClustername %>%
  
  filter(intercluster == "1" & interdatacenter == "1")


datasetcombinedwithClustername = rbind(datasetclusterAfilterwithClustername, datasetclusterCfilterwithClustername)

datasetcombinedwithClusternamebothintra = rbind(datasetclusterAwithClusternamebothintra, 
                                                
                                                datasetclusterCwithClusternamebothintra)

datasetcombinedwithClusternameintercluster = rbind(datasetclusterAwithClusternameintercluster,
                                                   
                                                   datasetclusterCwithClusternameintercluster)

datasetcombinedwithClusternameinterdatacenter = rbind(datasetclusterAwithClusternameinterdatacenter,
                                                      
                                                      datasetclusterCwithClusternameinterdatacenter)


#Pattern finding in traffic - source and destination pairs

datasetclusterArackpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourceRack, anonymizeddestinationRack, sort = TRUE)

datasetclusterCrackpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourceRack, anonymizeddestinationRack, sort = TRUE)

datasetclusterApodpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourcePod, anonymizeddestinationPod, sort = TRUE)

datasetclusterCpodpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourcePod, anonymizeddestinationPod, sort = TRUE)

datasetclusterArackpodpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourcePod, anonymizedsourceRack, sort = TRUE)

datasetclusterCrackpodpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourcePod, anonymizedsourceRack, sort = TRUE)

datasetclusterAhostprefixpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)
  
datasetclusterAl4portpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourceL4Port, anonymizeddestinationL4Port, sort = TRUE)

datasetclusterCl4portpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourceL4Port, anonymizeddestinationL4Port, sort = TRUE)


#Pattern finding in traffic - source and destination pairs

datasetclusterAIPpairing = datasetclusterAfilterwithClustername %>%
  
  count(anonymizedsourceIP, anonymizeddestinationIP, sort = TRUE)

datasetclusterCIPpairing = datasetclusterCfilterwithClustername %>%
  
  count(anonymizedsourceIP, anonymizeddestinationIP, sort = TRUE)


orderdatasetclusterAfilterwithClustername = datasetclusterAfilterwithClustername[order(datasetclusterAfilterwithClustername[,12], datasetclusterAfilterwithClustername[,10],
                                           
                                           datasetclusterAfilterwithClustername[,8], datasetclusterAfilterwithClustername[,5],
                                           
                                           datasetclusterAfilterwithClustername[,3]), ]


rowcountA = rle(paste(orderdatasetclusterAfilterwithClustername$anonymizedsourceIP, orderdatasetclusterAfilterwithClustername$anonymizeddestinationIP,
                          
                          orderdatasetclusterAfilterwithClustername$anonymizedsourceL4Port, orderdatasetclusterAfilterwithClustername$anonymizeddestinationL4Port,
                          
                          orderdatasetclusterAfilterwithClustername$IPprotocol, orderdatasetclusterAfilterwithClustername$anonymizedsourcehostprefix,
                          
                          orderdatasetclusterAfilterwithClustername$anonymizeddestinationhostprefix, orderdatasetclusterAfilterwithClustername$anonymizeddestinationhostprefix,
                          
                          orderdatasetclusterAfilterwithClustername$anonymizeddestinationhostprefix, orderdatasetclusterAfilterwithClustername$anonymizedsourceRack,
                          
                          orderdatasetclusterAfilterwithClustername$anonymizeddestinationRack, orderdatasetclusterAfilterwithClustername$anonymizedsourcePod,
                          
                          orderdatasetclusterAfilterwithClustername$anonymizeddestinationPod))$lengths



orderdatasetclusterCfilterwithClustername = datasetclusterCfilterwithClustername[order(datasetclusterCfilterwithClustername[,12], datasetclusterCfilterwithClustername[,10],
                                                                                       
                                                                                       datasetclusterCfilterwithClustername[,8], datasetclusterCfilterwithClustername[,5],
                                                                                       
                                                                                       datasetclusterCfilterwithClustername[,3]), ]


rowcountC = rle(paste(orderdatasetclusterCfilterwithClustername$anonymizedsourceIP, orderdatasetclusterCfilterwithClustername$anonymizeddestinationIP,
                      
                      orderdatasetclusterCfilterwithClustername$anonymizedsourceL4Port, orderdatasetclusterCfilterwithClustername$anonymizeddestinationL4Port,
                      
                      orderdatasetclusterCfilterwithClustername$IPprotocol, orderdatasetclusterCfilterwithClustername$anonymizedsourcehostprefix,
                      
                      orderdatasetclusterCfilterwithClustername$anonymizeddestinationhostprefix, orderdatasetclusterCfilterwithClustername$anonymizeddestinationhostprefix,
                      
                      orderdatasetclusterCfilterwithClustername$anonymizeddestinationhostprefix, orderdatasetclusterCfilterwithClustername$anonymizedsourceRack,
                      
                      orderdatasetclusterCfilterwithClustername$anonymizeddestinationRack, orderdatasetclusterCfilterwithClustername$anonymizedsourcePod,
                      
                      orderdatasetclusterCfilterwithClustername$anonymizeddestinationPod))$lengths




dataframerowcountA = as.data.frame(rowcountA)

dataframerowcountC = as.data.frame(rowcountC)






