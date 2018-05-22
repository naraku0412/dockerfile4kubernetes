#!/bin/bash

set -e

if [ ! -x "$(command -v getent)" ]; then
  echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - getent: no such file!"
  exit 1
fi
WAIT="10"
i=0
while true; do
  if [[ "$i" > "$TRIES" ]]; then
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

SEED="${DSCV}"-0."${DSCV}"."${POD_NAMESPACE}"
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
