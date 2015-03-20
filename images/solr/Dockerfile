FROM ubuntu:14.04

# Adapted from pataquets/solr and geoblacklight/solr
MAINTAINER Nikitas Tampakis <nikitas.tampakis@gmail.com>

ENV SOLR_VERSION 4.10.0
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_BL blacklight-jetty-$SOLR_VERSION
ENV APP_NAME orangelight

RUN apt-get update && apt-get -y install \
        unzip \
        wget \
        git \
        openjdk-7-jdk

RUN \
 wget https://github.com/projectblacklight/blacklight-jetty/archive/v$SOLR_VERSION.zip && \
 unzip v$SOLR_VERSION.zip && \
 rm v$SOLR_VERSION.zip && \
 mv $SOLR_BL /opt/solr
# wget http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz && \
# tar xvf $SOLR.tgz && \
# rm -v $SOLR.tgz && \
# mv $SOLR /opt/solr 

WORKDIR /opt

RUN git clone https://github.com/pulibrary/orangelight.git
RUN cp -r orangelight/solr_conf/conf/* /opt/solr/solr/blacklight-core/conf

WORKDIR /opt/solr

EXPOSE 8983

# CMD  [ "java", "-jar", "start.jar" ]
