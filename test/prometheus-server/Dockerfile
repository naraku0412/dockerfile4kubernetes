FROM 172.31.78.217:5000/git 

# prometheus-2.2.1.linux-amd64.tar.gz
# prometheus-2.2.1.linux-amd64

ENV prometheus_ver 2.2.1
ENV file_server http://172.31.78.216:2121

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# uncompress & rename svc 
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/prometheus-${prometheus_ver}.linux-amd64.tar.gz | \
      tar -zx && \
    ln -s prometheus-${prometheus_ver}.linux-amd64 prometheus && \
    echo Prometheus ${prometheus_ver} installed in /opt

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ENV PATH $PATH:/opt/prometheus
