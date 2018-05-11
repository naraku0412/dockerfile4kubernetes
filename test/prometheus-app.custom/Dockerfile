FROM 172.31.78.217:5000/prom-client as build
ADD main-v1.go /opt/
WORKDIR /opt
RUN go get -d
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o custom 

FROM alpine
COPY --from=build /opt/custom /
