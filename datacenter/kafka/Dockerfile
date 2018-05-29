FROM lowyard/busybox-curl:latest as build 
ENV kafka_ver 1.0.1 
ENV scala_ver 2.11 
ENV file_server http://10.254.0.21
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/kafka_${scala_ver}-${kafka_ver}.tgz | \
      tar -zx

#FROM ubuntu:16.04
FROM lowyard/ubuntu:16.04_openjdk-8-jdk_scala-2.11
ENV kafka_ver 1.0.1
ENV scala_ver 2.11
# uncompress & rename svc
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=build /opt/kafka_${scala_ver}-${kafka_ver} /opt/kafka_${scala_ver}-${kafka_ver}/
RUN ln -s kafka_${scala_ver}-${kafka_ver} kafka && \
    echo Kafka ${scala_ver}-${kafka_ver} installed in /opt
ADD entrypoint.sh /
ADD server.properties /opt/kafka/config/ 
ENV PATH $PATH:/opt/kafka/bin
