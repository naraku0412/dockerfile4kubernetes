#!/bin/bash

set -e

FILE_SERVER=$1
if [ -z "$FILE_SERVER" ]; then
  echo "[ERROR] - input the info of file server, in term of PROTO://IP:PORT"
  exit 0
fi

MARKER="ENV file_server"
TO="$MARKER $FILE_SERVER"

DOCKERFILES=$(find ./ -name "Dockerfile*" -type f)

for DOCKERFILE in $DOCKERFILES; do
  sed -i "/^${MARKER}/ c $TO" $DOCKERFILE
done
