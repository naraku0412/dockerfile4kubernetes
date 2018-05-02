FROM ubuntu-16.04 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN (echo '9ol.8ik,';sleep 1;echo '9ol.8ik,') | passwd root

ENV kairosdb_ver 1.2.0-1
ENV ftp_server 172.31.78.216:2121

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y curl

RUN mkdir -p /opt && \
    cd /opt && \
    curl ftp://${ftp_server}/kairosdb-${kairosdb_ver}.tar.gz | \
      tar -zx && \
    #ln -s kairosdb-${kairosdb_ver} cassandra && \
    echo Kairosdb ${kairosdb_ver} installed in /opt

RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ADD kairosdb.properties /opt/kairosdb/conf/kairosdb.properties
ADD logback.xml /opt/kairosdb/conf/logging/logback.xml
ENV PATH $PATH:/opt/kairosdb/bin
