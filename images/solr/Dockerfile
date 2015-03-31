FROM ubuntu:14.04
#FROM tomcat:7

# Adapted from pataquets/solr and geoblacklight/solr
MAINTAINER Nikitas Tampakis <nikitas.tampakis@gmail.com>

ENV SOLR_VERSION 4.10.0
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_BL blacklight-jetty-$SOLR_VERSION
ENV APP_NAME orangelight
ENV JVM_XMS 1G
ENV JVM_XMX 6G
ENV MAX_PERM 128M
ENV USER tomcat7
ENV GROUP tomcat7
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64


RUN apt-get update && apt-get -y install \
        unzip \
        wget \
        tomcat7



#RUN \
# cp /etc/default/tomcat7 /etc/default/tomcat7.bak && \
# echo "# A backup of the original file with addition options is at /etc/default/tomcat7.bak\n\
#TOMCAT7_USER=$USER\n\
#TOMCAT7_GROUP=$GROUP\n\
#JAVA_HOME=$JAVA_HOME\n\
#JAVA_OPTS=\"-Djava.awt.headless=true\
# -XX:+UseG1GC\
# -XX:+UseCompressedOops\
# -XX:-UseLargePagesIndividualAllocation\
# -XX:MaxPermSize=$MAX_PERM\
# -Xms$JVM_XMS -Xmx$JVM_XMX\
# -Djava.util.logging.config.file=/etc/tomcat7/logging.properties\
# -server\"" > /etc/default/tomcat7

#RUN service tomcat7 restart

#RUN \
# wget https://github.com/projectblacklight/blacklight-jetty/archive/v$SOLR_VERSION.zip && \
# unzip v$SOLR_VERSION.zip && \
# rm v$SOLR_VERSION.zip && \
# mv $SOLR_BL /opt/solr
# wget http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz && \
# tar xvf $SOLR.tgz && \
# rm -v $SOLR.tgz && \
# mv $SOLR /opt/solr 

#WORKDIR /opt

#RUN git clone https://github.com/pulibrary/orangelight.git
#RUN cp -r orangelight/solr_conf/conf/* /opt/solr/solr/blacklight-core/conf

#WORKDIR /opt/solr

EXPOSE 8080


# CMD  [ "java", "-jar", "start.jar" ]
