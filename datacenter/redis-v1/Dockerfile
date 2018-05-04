FROM ubuntu-16.04 as build

ENV redis_ver 4.0.9
ENV file_server http://172.31.78.216:2121

RUN apt-get update && \
    apt-get install -y gcc make tcl ruby curl

RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/redis-${redis_ver}.tar.gz | \
      tar -zx && \
    ln -s redis-${redis_ver} redis && \
    echo Redis ${redis_ver} installed in /opt

WORKDIR /opt/redis
RUN make MALLOC=libc
RUN make test

FROM alpine:latest
RUN mkdir -p /opt
COPY --from=build /opt/ /opt
ADD redis.conf /opt/redis/
