#!/bin/bash

set -e

FROM="ftp_server"
TO="file_server"

DOCKERFILES=$(find ./ -name "Dockerfile*" -type f)

for DOCKERFILE in $DOCKERFILES; do
  sed -i s%"$FROM"%"$TO"%g $DOCKERFILE
done
