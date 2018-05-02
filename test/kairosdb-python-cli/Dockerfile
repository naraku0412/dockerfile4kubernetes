FROM python 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update && \
    apt-get install -y python-pip && \
    apt-get install -y netcat && \
    apt-get install -y vim 

RUN pip install requests

RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ADD kairosdb-multi-p.py kairosdb-multi-t.py kairos-test.py /
