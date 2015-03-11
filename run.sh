#!/bin/bash
set -e

TAG=${TAG:-rancher/agent-instance:dev}
docker build -t $TAG .
docker run --privileged -t -i -e CATTLE_ACCESS_KEY=ai -e CATTLE_SECRET_KEY=aipass -e CATTLE_URL=http://172.17.42.1:8080/v1 $TAG "$@"
