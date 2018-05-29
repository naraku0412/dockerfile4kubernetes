FROM lowyard/busybox-curl:latest as build
ENV etcd_ver v3.3.2
ENV file_server http://10.254.0.21
# uncompress
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/etcd-${etcd_ver}-linux-amd64.tar.gz | \
        tar -zx 

FROM bash:latest 
FROM ubuntu:16.04 
ENV etcd_ver v3.3.2
# uncompress & rename svc
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=build /opt/etcd-${etcd_ver}-linux-amd64/ /opt/etcd-${etcd_ver}-linux-amd64/
# rename svc
RUN ln -s etcd-${etcd_ver}-linux-amd64 etcd && \
    echo Etcd ${etcd_ver} installed in /opt
#RUN ln -s /usr/local/bin/bash /bin/bash
ADD entrypoint.sh /
ENV PATH $PATH:/opt/etcd
