#!/bin/bash

set -e

sed -i "s/{{cassandra.ip}}/${POD_IP}/g" /opt/kairosdb/conf/kairosdb.properties

/opt/kairosdb/bin/kairosdb.sh run
