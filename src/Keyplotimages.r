#Packet length over a period of time


library(tidyverse)

datasetClusterAtimestamptraffic %>% 
  
  ggplot(aes(x = timestamp, y = packetlength, group = clusterdatacenter, color = as.factor(clusterdatacenter))) + 
    
  geom_line() + geom_point() +
    
  scale_color_manual(values=c('#FF0000','#0000FF', '#097969')) + 
    
  labs(color = "clusterdatacenter") + ggtitle("Database cluster - Packet length over the period of time") + theme_minimal()
  


datasetClusterCtimestamptraffic %>% 
  
  ggplot(aes(x = timestamp, y = packetlength, group = clusterdatacenter, color = as.factor(clusterdatacenter))) + 
  
  geom_line() + geom_point() +
  
  scale_color_manual(values=c('#FF0000','#0000FF', '#097969')) + 
  
  labs(color = "clusterdatacenter") + ggtitle("Hadoop cluster - Packet length over the period of time") + theme_minimal()
  