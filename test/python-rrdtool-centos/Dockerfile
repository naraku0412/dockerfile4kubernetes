FROM centos-7 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum makecache && \
    yum install -y python-rrdtool

RUN yum clean all && \
    rm -rf /var/cache/yum
