# dockerhub
Docker images for Orangelight and other related projects. Specific readmes are provided for each image. Summaries for each are included here. They are linked to automated builds on [dockerhub](https://hub.docker.com/u/tampakis/).

### solr_tomcat
Adapted from [raycoding/piggybank-solr-tomcat](https://github.com/raycoding/piggybank-solr-tomcat) with [orangelight-specific configuration](https://github.com/pulibrary/orangelight).

### zookeeper
Adapted from [raycoding/piggybank-zookeeper](https://github.com/raycoding/piggybank-zookeeper). The zookeeper manages the SolrCloud cluster.

### solr
Should probably be removed. This was the first attempt to get a proper solr/tomcat environment, but apparently the apt-get tomcat7 on the Docker Ubuntu image [incorrectly reports service status](http://stackoverflow.com/questions/24451047/service-tomcat7-start-fails-but-the-process-exists-and-tomcat-is-running).
