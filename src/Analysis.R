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




