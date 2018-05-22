#!/bin/bash

set -e

SEED=${POD_IP}
THIS_IP=$POD_IP
THIS_NAME=$(hostname -s)
ALIAS=$(echo $THIS_NAME | awk -F '-' '{print $1}')
ID=$(echo $THIS_NAME | awk -F '-' '{print $2}')
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - IP: ${THIS_IP}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - ID: ${ID}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Alias: ${ALIAS}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - svc discovery: $DSCV"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - pod namespace: ${POD_NAMESPACE}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - seed: ${SEED}"

# 1 cluster name
sed -i "s/{{cluster.name}}/${CLUSTER_NAME}/g" /opt/cassandra/conf/cassandra.yaml

# 2 seed
sed -i "s/{{seed.ip}}/$SEED/g" /opt/cassandra/conf/cassandra.yaml

# 3 listen address
sed -i "s/{{pod.ip}}/${POD_IP}/g" /opt/cassandra/conf/cassandra.yaml

# 4 listen address
sed -i "s/{{pod.ip}}/${POD_IP}/g" /opt/cassandra/conf/cassandra.yaml

# 5 data file directories 
sed -i s^"var/libi"^"mnt/$(hostname -s)"^g /opt/cassandra/conf/cassandra.yaml

/opt/cassandra/bin/cassandra -f -R
