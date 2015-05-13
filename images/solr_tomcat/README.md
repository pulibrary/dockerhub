# Solr running with Tomcat on Docker
	
Automated SolrCloud Bootstrap with **Solr 4.10.0** running on **Apache Tomcat 7.0.59** and cluster managed with **ZooKeeper 3.4.6**.

`sudo` is required for native Linux docker installations. `sudo docker pull tampakis/solr_tomcat`

Adapted from [raycoding/piggybank-solr-tomcat](https://github.com/raycoding/piggybank-solr-tomcat) with [orangelight-specific configuration](https://github.com/pulibrary/orangelight).. The zookeeper image which manages the SolrCloud cluster is defined at [tampakis/zookeeper](https://registry.hub.docker.com/u/tampakis/zookeeper/).

This image is linked on [Docker Hub](https://registry.hub.docker.com/u/tampakis/solr_tomcat/) and [Github](https://github.com/pulibrary/dockerhub) under `images/solr_tomcat`. There are additional config files and scripts located there required for the build.


### Starting SolrCloud
  - Start zookeeper
  	- `sudo docker run --name zookeeper -dit -p 8383:8383 -p 2181:2181 -p 2888:2888 -p 3888:3888 -e HOSTNAME=127.0.0.1 tampakis/zookeeper`
  - For the first Nodes, we will simultaneously also upload the solr configuration into ZooKeeper using Zookeeper Command Line Interface tools shipped with Solr and is available in this docker image at /solr-zk-cli
    - `sudo docker run --link zookeeper:ZK --name=nodeA -dit -p 8984:8080 -e 'SOLR_OPTS="-DzkHost=$ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT"' tampakis/solr_tomcat:4.10.0 /bin/bash -c 'java -classpath .:/solr-zk-cli/* org.apache.solr.cloud.ZkCLI -cmd upconfig -zkhost $ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT -confdir /solr-home/blacklight-core/conf -confname example ; /usr/lib/apache-tomcat-7.0.59/bin/catalina.sh run'`
  - In the above step we reference zookeeper container as created in step 1 as ZK in our new container for running tomcat and solr node. **ZK_* environment** variables in the container are used to locate the ZooKeeper container with zkHost params. We only need to upload solr configuration once to ZooKeeper.
  - Second Node, `sudo docker run --link zookeeper:ZK --name=nodeB -dit -p 8985:8080 -e 'SOLR_OPTS="-DzkHost=$ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT"' tampakis/solr_tomcat:4.10.0 /bin/bash -c '/usr/lib/apache-tomcat-7.0.59/bin/catalina.sh run'`
  - Third Node, `sudo docker run --link zookeeper:ZK --name=nodeC -dit -p 8986:8080 -e 'SOLR_OPTS="-DzkHost=$ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT"' tampakis/solr_tomcat:4.10.0 /bin/bash -c '/usr/lib/apache-tomcat-7.0.59/bin/catalina.sh run'`
  - Now that we have uploaded our solr configurations and three nodes are ready to serve, we can create a new collection in Solr Cloud
    - From you local host machine run `curl "http://localhost:8984/solr/admin/collections?action=CREATE&name=orangelight&numShards=3&replicationFactor=2&maxShardsPerNode=2"` or paste the same in browser.
  - Voila you have Solr Cloud setup! `http://localhost:8984/solr, http://localhost:8985/solr, http://localhost:8986/solr`

### Tomcat/Solr Port and Memory Management
The tomcat defualt port `8080` is used on the individual solr instances. This can be changed by uncommenting the `RUN sed -i s/8080/8983/g /usr/lib/$TOMCAT/conf/server.xml` line in the Dockerfile. That command would change the port to 8983. The port would also need to be changed in the SOLR_OPTS set in the `apache_tomcat_setenv.sh` file located in the [Github repository](https://github.com/pulibrary/dockerhub) along with this image. That file also will be where we can tweak the memory options for the server.

### Changing Versions of Solr or Tomcat
To change the versions of Solr and Tomcat, set the desired version in the appropriate `SOLR_VERSION` and `TOMCAT_VERSION` environment variables in the Dockerfile. The `$TOMCAT_HOME/conf/Catalina/localhost/solr.xml` file needs to be updated with the correct Tomcat version in the `echo` command in setting the Orangelight-specific config of the Dockerfile. The Tomcat version would also need to be updated in the docker commands listed above for starting the SolrCloud (apache-tomcat-$TOMCAT_VERSION).

The locations of the Solr and Tomcat distributions would also need to be updated in the `apache_tomcat_setenv.sh` file if they are changed in the Dockerfile.