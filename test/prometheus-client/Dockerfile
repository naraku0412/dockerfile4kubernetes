FROM 172.31.78.217:5000/git 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /opt
RUN git clone https://github.com/prometheus/client_golang.git
WORKDIR /opt/client_golang/examples/random
RUN go get -d
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo
