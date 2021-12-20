#How do traffic characteristics vary over time?

datasetClusterAtimestamptraffic %>%
  
  ggplot(aes(timestamp, fill = clusterdatacenter)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Database cluster - Overall") + theme_minimal()

datasetclusterAbothintra %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Database cluster - Intra cluster - Intra datacenter") + 
  
  theme_minimal()

datasetclusterAintercluster %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Database cluster - Inter cluster - Intra datacenter") + 
  
  theme_minimal()

datasetclusterAinterdatacenter %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Database cluster - Inter cluster - Inter datacenter") + 
  
  theme_minimal()




datasetClusterCtimestamptraffic %>%
  
  ggplot(aes(timestamp, fill = clusterdatacenter)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Hadoop cluster - Overall") + theme_minimal()

datasetclusterCbothintra %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Hadoop cluster - Intra cluster - Intra datacenter") + 
  
  theme_minimal()

datasetclusterCintercluster %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Hadoop cluster - Inter cluster - Intra datacenter") + 
  
  theme_minimal()

datasetclusterCinterdatacenter %>%
  
  ggplot(aes(timestamp)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Hadoop cluster - Inter cluster - Inter datacenter") + 
  
  theme_minimal()


#What patterns are present in the transmission of data? 

#Are there particular source-destination pairs which represent a large quantity of traffic?

datasetclusterAIPpairing %>%
  
  slice(1:25) %>%

  ggplot(aes(x = anonymizedsourceIP, y = anonymizeddestinationIP, xend = anonymizedsourceIP, yend = anonymizeddestinationIP)) +
  
  geom_nodes(size = 8) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination IP - Database Cluster") +
  
  theme_minimal()


datasetclusterCIPpairing %>%
  
  slice(1:25) %>%
  
  ggplot(aes(x = anonymizedsourceIP, y = anonymizeddestinationIP, xend = anonymizedsourceIP, yend = anonymizeddestinationIP)) +
  
  geom_nodes(size = 8) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination IP - Hadoop Cluster") +
  
  theme_minimal()



#How do different workload types (i.e. Database, Web, Hadoop) exhibit different traffic characteristics?


datasetcombinedwithClustername %>%
  
  ggplot(aes(timestamp, fill = `clustername`)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Facebook data center - Traffic characteristics - Database and Hadoop server - Overall") + theme_minimal()


datasetcombinedwithClusternamebothintra %>%
  
  ggplot(aes(timestamp, fill = `clustername`)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Traffic characteristics - Database and Hadoop server - Intra cluster and Intra datacenter") + 
  
  theme_minimal()


datasetcombinedwithClusternameintercluster %>%
  
  ggplot(aes(timestamp, fill = `clustername`)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Traffic characteristics - Database and Hadoop server - Inter cluster and Intra datacenter") + 
  
  theme_minimal()


datasetcombinedwithClusternameinterdatacenter %>%
  
  ggplot(aes(timestamp, fill = `clustername`)) + geom_histogram(binwidth = 1000) +
  
  ggtitle("Traffic characteristics - Database and Hadoop server - Inter cluster and Inter datacenter") + 
  
  theme_minimal()


#What patterns are present with respect to rack- and pod-locality?


datasetclusterArackpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourceRack, y = anonymizeddestinationRack, xend = anonymizedsourceRack, yend = anonymizeddestinationRack)) +
  
  geom_nodes(size = 10) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination Rack - Database Cluster") +
  
  theme_minimal()


datasetclusterCrackpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourceRack, y = anonymizeddestinationRack, xend = anonymizedsourceRack, yend = anonymizeddestinationRack)) +
  
  geom_nodes(size = 12) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination Rack - Hadoop Cluster") +
  
  theme_minimal()



datasetclusterApodpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourcePod, y = anonymizeddestinationPod, xend = anonymizedsourcePod, yend = anonymizeddestinationPod)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination Pod - Database Cluster") +
  
  theme_minimal()


datasetclusterCpodpairing %>%
  
  slice(1:25) %>%
  
  ggplot(aes(x = anonymizedsourcePod, y = anonymizeddestinationPod, xend = anonymizedsourcePod, yend = anonymizeddestinationPod)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination Pod - Hadoop Cluster") +
  
  theme_minimal()


datasetclusterAhostprefixpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourcehostprefix, y = anonymizeddestinationhostprefix, xend = anonymizedsourcehostprefix, yend = anonymizeddestinationhostprefix)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination hostprefix - Database Cluster") +
  
  theme_minimal()


datasetclusterChostprefixpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourcehostprefix, y = anonymizeddestinationhostprefix, xend = anonymizedsourcehostprefix, yend = anonymizeddestinationhostprefix)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination hostprefix - Hadoop Cluster") +
  
  theme_minimal()


datasetclusterAl4portpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourceL4Port, y = anonymizeddestinationL4Port, xend = anonymizedsourceL4Port, yend = anonymizeddestinationL4Port)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination L4 port - Database Cluster") +
  
  theme_minimal()


datasetclusterCl4portpairing %>%
  
  slice(1:10) %>%
  
  ggplot(aes(x = anonymizedsourceL4Port, y = anonymizeddestinationL4Port, xend = anonymizedsourceL4Port, yend = anonymizeddestinationL4Port)) +
  
  geom_nodes(size = 16) +
  
  geom_nodetext(aes(label = n), color = "white") +
  
  ggtitle("Traffic between source and destination L4 port - Hadoop Cluster") +
  
  theme_minimal()


datasetclusterAfilter %>%
 
   count(IPprotocol, sort = TRUE)

datasetclusterCfilter %>%
  
  count(IPprotocol, sort = TRUE)







