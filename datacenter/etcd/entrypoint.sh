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

THIS_IP=$POD_IP
THIS_NAME=$(hostname -s)
ALIAS=$(echo $THIS_NAME | awk -F '-' '{print $1}')
ID=$(echo $THIS_NAME | awk -F '-' '{print $2}')
#ID=$(echo $THIS_NAME | awk -F '-' '{print $2}' | awk -F '.' '{print $1}')
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Nodes in this cluster: $N_NODES"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - IP: ${THIS_IP}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - ID: ${ID}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Alias: ${ALIAS}"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - svc discovery: $DSCV"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - pod namespace: ${POD_NAMESPACE}"

if false; then
ETCD_NODES=""
for i in $(seq -s ' ' 1 $N_NODES); do
  ETCD_NODES+=','
  j=$[$i-1]
  NAME="$ALIAS-$j"
  if [ "$j" == "$ID" ]; then
    IP=$THIS_IP
  else
    IP=""
    TRY=0
    IP=$(getent hosts $NAME.$DSCV | awk -F ' ' '{print $1}')
    while [ -z "$IP" ]; do
      sleep 1
      TRY=$[${TRY}+1]
      if [ "$TRY" -gt "$TRIES" ]; then
        echo "=== Cannot resolve the DNS entry for ${NAME}. Has the service been created yet, and is SkyDNS functional?"
        echo "=== See http://kubernetes.io/v1.1/docs/admin/dns.html for more details on DNS integration."
        echo "=== Sleeping ${WAIT}s before pod exit."
        sleep $WAIT
        exit 0
      fi
      IP=$(getent hosts $NAME.$DSCV | awk -F ' ' '{print $1}')
    done
  fi
  ETCD_NODES+="$NAME=http://$IP:2380"
done
ETCD_NODES=${ETCD_NODES#*,}
fi

ETCD_NODES=""
SEP=''
for i in $(seq -s ' ' 1 $N_NODES); do
  ETCD_NODES+="$SEP"
  j=$[$i-1]
  NAME="$ALIAS-$j"
  ETCD_NODES+="$NAME=http://$NAME.$DSCV.${POD_NAMESPACE}:2380"
  SEP=","
done

echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - Etcd nodes: $ETCD_NODES"
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - this name: ${THIS_NAME}"

[ -e /mnt/$(hostname -s)/etcd ] || mkdir -p /mnt/$(hostname -s)/etcd
[ -e "/mnt/$(hostname -s)/etcd/member" ] && rm -rf /mnt/$(hostname -s)/etcd/member
if false; then
if [ -e "/mnt/$(hostname -s)/etcd/member" ]; then
  STATUS="existing"
else
  STATUS="new"
fi
echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - $0 - status: ${STATUS}"
fi

/opt/etcd/etcd --data-dir=/mnt/$(hostname -s)/etcd \
  --name ${THIS_NAME} \
  --initial-advertise-peer-urls http://${THIS_IP}:2380 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --advertise-client-urls http://${THIS_IP}:2379 \
  --listen-client-urls http://0.0.0.0:2379 \
  --initial-cluster ${ETCD_NODES} \
  #--initial-cluster-state ${STATUS} \
  --initial-cluster-state new \
  --initial-cluster-token ${TOKEN} \
  --force-new-cluster
