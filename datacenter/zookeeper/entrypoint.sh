#!/bin/bash

set -e

WAIT="10"
i=0
while true; do
  if [ "$i" -gt "$TRIES" ]; then
    echo "=== Cannot resolve the DNS entry for $DSCV. Has the service been created yet, and is SkyDNS functional?"
    echo "=== See http://kubernetes.io/v1.1/docs/admin/dns.html for more details on DNS integration."
    echo "=== Sleeping ${WAIT}s before pod exit."
    sleep $WAIT
    exit 0
  fi
  if ! getent hosts $DSCV; then
    i=$[i+1]
    sleep 1
  else
    break;
  fi
done

THIS_IP=${POD_IP}
THIS_NAME=$(hostname -s)
ALIAS=$(echo $THIS_NAME | awk -F '-' '{print $1}')
ID=$(echo $THIS_NAME | awk -F '-' '{print $2}')
MYID=$[${ID}+1]
#ID=$(echo $THIS_NAME | awk -F '-' '{print $2}' | awk -F '.' '{print $1}')
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Nodes in this cluster: $N_NODES"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - IP: ${THIS_IP}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - ID: ${ID}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - MYID: ${MYID}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Alias: ${ALIAS}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - svc discovery: $DSCV"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - pod namespace: $POD_NAMESPACE"

# set myid
[ -e /mnt/$(hostname -s)/zookeeper ] || mkdir -p /mnt/$(hostname -s)/zookeeper
cd /mnt/$(hostname -s)/zookeeper && \
  touch myid && \
  echo "$MYID" > myid

sed -i s^"var/lib"^"mnt/$(hostname -s)"^g /opt/zookeeper/conf/zoo.cfg

for i in $(seq -s ' ' 1 $N_NODES); do
  j=$[$i-1]
  if [ "$j" == "$ID" ]; then
    echo "server.$MYID=0.0.0.0:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
    IP=$THIS_IP
    NAME=$THIS_NAME
  else
    NAME="${ALIAS}-$j"
    echo "server.$i=${NAME}.${DSCV}.${POD_NAMESPACE}:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
  fi
done

/opt/zookeeper/bin/zkServer.sh start-foreground
