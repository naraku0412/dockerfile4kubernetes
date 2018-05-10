FROM 172.31.78.217:5000/git as build
WORKDIR /opt
RUN git clone https://github.com/prometheus/client_golang.git
WORKDIR /opt/client_golang/examples/random
RUN go get -d
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo 

FROM alpine
COPY --from=build /opt/client_golang/examples/random/random /
