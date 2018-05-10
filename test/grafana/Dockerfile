FROM 172.31.78.217:5000/git 

ENV grafana_ver 5.1.2
ENV file_server http://172.31.78.216:2121

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# uncompress & rename svc 
# grafana-5.1.2 grafana-5.1.2.linux-x64.tar.gz
RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/grafana-${grafana_ver}.linux-x64.tar.gz | \
      tar -zx && \
    ln -s grafana-${grafana_ver} grafana && \
    echo Grafana ${grafana_ver} installed in /opt

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

WORKDIR /opt/grafana
ENV PATH $PATH:/opt/grafana/bin
