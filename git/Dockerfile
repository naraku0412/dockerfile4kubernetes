FROM golang 

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y git

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /usr/share/man /usr/share/doc
