FROM openjdk 

ENV hadoop_ver 2.7.3 
ENV spark_ver 2.2.0
ENV kubernetes_support_ver 0.5.0
ENV file_server http://172.31.78.216:2121

RUN apt-get update && \
    apt-get install -y curl

# Get Spark from .
RUN mkdir -p /opt && \
    cd /opt && \
    #tar -zxf spark-${spark_ver}-bin-hadoop2.7.tgz && \
    curl ${file_server}/spark-${spark_ver}-k8s-${kubernetes_support_ver}-bin-with-hadoop-{hadoop_ver}.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-k8s-${kubernetes_support_ver}-bin-{hadoop_ver} spark && \
    echo Spark ${spark_ver} distribution with Kubernetes ${kubernetes_support_ver} support installed in /opt

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ENV PATH $PATH:/opt/spark/bin
