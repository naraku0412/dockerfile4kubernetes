FROM lowyard/busybox-curl as build
ENV file_server http://10.254.0.21
ENV cassandra_ver 3.11.2
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/apache-cassandra-${cassandra_ver}-bin.tar.gz | tar -zx

#FROM openjdk:8u171-jdk-slim-stretch
FROM lowyard/ubuntu:16.04_openjdk-8-jdk
RUN mkdir -p /opt
WORKDIR /opt
ENV cassandra_ver 3.11.2
COPY --from=build /opt/apache-cassandra-${cassandra_ver} /opt/apache-cassandra-${cassandra_ver}/
RUN ln -s apache-cassandra-${cassandra_ver} cassandra && \
    echo Cassandra ${cassandra_ver} installed in /opt
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc
ADD cassandra.yaml /opt/cassandra/conf/
ADD entrypoint.sh /
ADD start-seed.sh /
ENV PATH $PATH:/opt/cassandra/bin
