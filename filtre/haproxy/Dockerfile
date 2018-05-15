FROM ubuntu-16.04 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update && \
    apt-get install -y haproxy
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ADD liveness-probe.sh / 
