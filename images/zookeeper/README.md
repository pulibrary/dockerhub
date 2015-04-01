# Zookeeper on Docker
	
**Zookeeper 3.4.6** running on Docker with **Exhibitor 1.5.1**. `sudo` is required for native Linux docker installations. `sudo docker pull tampakis/zookeeper`

Adapted from [raycoding/piggybank-zookeeper](https://github.com/raycoding/piggybank-zookeeper). The zookeeper manages the SolrCloud cluster defined in the [solr_tomcat image](https://registry.hub.docker.com/u/tampakis/solr_tomcat/).

This image is linked on [Docker Hub](https://registry.hub.docker.com/u/tampakis/zookeeper/) and [Github](https://github.com/pulibrary/dockerhub) under `images/zookeeper`. There are additional config files and scripts located there required for the build.


### Starting ZooKeeper
  - Exhibitor is a supervisory process that manages each of your ZooKeeper server processes [Read more](https://github.com/Netflix/exhibitor).
  - To start we need to define a name for the zookeeper instance, map the ports and pass the required configuration parameters.
  	- `sudo docker run --name zookeeper -dit -p 8383:8383 -p 2181:2181 -p 2888:2888 -p 3888:3888 -e HOSTNAME=127.0.0.1 tampakis/zookeeper`