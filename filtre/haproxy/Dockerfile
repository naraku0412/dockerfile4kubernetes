FROM debian:stable 

RUN apt-get update && \
    apt-get install -y haproxy
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ADD liveness-probe.sh / 
