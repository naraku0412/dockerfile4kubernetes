FROM lowyard/busybox-curl:latest as build
ENV zookeeper_ver 3.4.11
ENV file_server http://172.31.78.216:2121
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/zookeeper-${zookeeper_ver}.tar.gz | \
      tar -zx

FROM openjdk:8u171-jdk-slim-stretch 
ENV zookeeper_ver 3.4.11
# uncompress & rename svc
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=build /opt/zookeeper-${zookeeper_ver} /opt/zookeeper-${zookeeper_ver}/
# rename svc 
RUN ln -s zookeeper-${zookeeper_ver} zookeeper && \
    echo Zookeeper ${zookeeper_ver} installed in /opt
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc
ADD zoo.cfg /opt/zookeeper/conf/
ADD entrypoint.sh /
ENV PATH $PATH:/opt/zookeeper/bin
