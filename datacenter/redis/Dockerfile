FROM ubuntu-16.04

ENV redis_ver 4.0.9
ENV file_server http://10.254.0.21

RUN apt-get update && \
    apt-get install -y gcc make tcl ruby curl

RUN mkdir -p /opt && \
    cd /opt && \
    curl ${file_server}/redis-${redis_ver}.tar.gz | \
      tar -zx && \
    ln -s redis-${redis_ver} redis && \
    echo Redis ${redis_ver} installed in /opt

WORKDIR /opt/redis
RUN make MALLOC=libc > /dev/null
RUN make test > /dev/null

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc

ADD redis.conf /opt/redis/
ADD entrypoint.sh /
ENV PATH $PATH:/opt/redis/src
