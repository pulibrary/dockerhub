FROM ubuntu:14.04
MAINTAINER Nikitas Tampakis <nikitas.tampakis@gmail.com>

ENV JRUBY_VERSION 1.7.19

WORKDIR /usr/local

RUN apt-get update && apt-get -y install \
    unzip \
    wget \
    git \
    curl \
    libxml2-dev \
    default-jdk

# Install jruby
RUN curl http://jruby.org.s3.amazonaws.com/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz | tar -xz && \
    echo 'gem: --no-ri --no-rdoc' > /etc/gemrc

ENV PATH /usr/local/jruby-$JRUBY_VERSION/bin:$PATH

# Install bundler
RUN gem install bundler 

WORKDIR /opt

# Download indexer and install gem dependencies
RUN git clone https://github.com/pulibrary/orangeindex.git && \
    cd orangeindex && \
    bundle install