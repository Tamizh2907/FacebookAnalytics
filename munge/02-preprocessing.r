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


#Identifying traffic of different clusters
  
datasetclusterAfilterwithClustername = datasetclusterAfilter 

datasetclusterAfilterwithClustername['clustername'] = 'Database'

datasetclusterCfilterwithClustername = datasetclusterCfilter 

datasetclusterCfilterwithClustername['clustername'] = 'Hadoop server'


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

datasetclusterArackpairing = datasetclusterAfilter %>%
  
  count(anonymizedsourceRack, anonymizeddestinationRack, sort = TRUE)

datasetclusterCrackpairing = datasetclusterCfilter %>%
  
  count(anonymizedsourceRack, anonymizeddestinationRack, sort = TRUE)

datasetclusterApodpairing = datasetclusterAfilter %>%
  
  count(anonymizedsourcePod, anonymizeddestinationPod, sort = TRUE)

datasetclusterCpodpairing = datasetclusterCfilter %>%
  
  count(anonymizedsourcePod, anonymizeddestinationPod, sort = TRUE)

datasetclusterAhostprefixpairing = datasetclusterAfilter %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairing = datasetclusterCfilter %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)
  
datasetclusterAl4portpairing = datasetclusterAfilter %>%
  
  count(anonymizedsourceL4Port, anonymizeddestinationL4Port, sort = TRUE)

datasetclusterCl4portpairing = datasetclusterCfilter %>%
  
  count(anonymizedsourceL4Port, anonymizeddestinationL4Port, sort = TRUE)



#Classification of host prefix with IP protocol, cluster and datacenter

datasetclusterAhostprefixpairingbothintraIP6 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterclusterIP6 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterdatacenterIP6 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)


datasetclusterAhostprefixpairingbothintraIP17 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterclusterIP17 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterdatacenterIP17 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)


datasetclusterAhostprefixpairingbothintraIP58 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterclusterIP58 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterAhostprefixpairinginterdatacenterIP58 = datasetclusterAfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)



datasetclusterChostprefixpairingbothintraIP6 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterclusterIP6 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterdatacenterIP6 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '6') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)


datasetclusterChostprefixpairingbothintraIP17 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterclusterIP17 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterdatacenterIP17 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '17') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)


datasetclusterChostprefixpairingbothintraIP58 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '0' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterclusterIP58 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '1' & interdatacenter == '0') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)

datasetclusterChostprefixpairinginterdatacenterIP58 = datasetclusterCfilter %>%
  
  filter(IPprotocol == '58') %>%
  
  filter(intercluster == '1' & interdatacenter == '1') %>%
  
  count(anonymizedsourcehostprefix, anonymizeddestinationhostprefix, sort = TRUE)



