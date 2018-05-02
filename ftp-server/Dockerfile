FROM golang:latest as build
ADD ftp-server.go /
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /ftp-server /ftp-server.go
FROM alpine:latest
COPY --from=build /ftp-server /
