#!/bin/bash

set -e

ZK_PORT=2181

THIS_IP=$(hostname -i)
THIS_NAME=$(hostname -s)
ALIAS=$(echo $THIS_NAME | awk -F '-' '{print $1}')
ID=$(echo $THIS_NAME | awk -F '-' '{print $2}')
#ID=$(echo $THIS_NAME | awk -F '-' '{print $2}' | awk -F '.' '{print $1}')
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Nodes in this cluster: $N_NODES"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - IP: ${THIS_IP}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - ID: ${ID}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Alias: ${ALIAS}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - svc discovery: $DSCV"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - pod namespace: $POD_NAMESPACE"

# get zk info
SEP=''
ZK_HOSTS=''
for i in $(seq -s ' ' 1 3); do
  j=$[i-1]
  ZK_HOSTS+="$SEP"
  ZK_HOSTS+="${DSCV}-$j.${DSCV}.${POD_NAMESPACE}:${ZK_PORT}"
  SEP=','
done
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - zk info: $ZK_HOSTS"

[ -e /mnt/$(hostname -s) ] || mkdir -p /mnt/$(hostname -s)
sed -i "s/{{broker.id}}/${ID}/g" /opt/kafka/config/server.properties
sed -i s^"tmp/kafka-logs"^"mnt/$(hostname -s)"^g /opt/kafka/config/server.properties
#sed -i "s/\#delete.topic.enable=true/delete.topic.enable=true/g" /opt/kafka/config/server.properties
sed -i "s/{{zookeeper.nodes}}/${ZK_HOSTS}/g" /opt/kafka/config/server.properties
echo -e "\n\nlog.cleaner.enable=true\n" >> /opt/kafka/config/server.properties

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
