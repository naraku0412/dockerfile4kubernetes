FROM 172.31.78.217:5000/git 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update && \
    apt-get install -y vim

WORKDIR /opt
RUN git clone https://github.com/prometheus/client_golang.git
WORKDIR /opt/client_golang/examples/random
RUN go get -d
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc
