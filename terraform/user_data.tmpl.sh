#!/bin/bash
apt-get update 
apt-get install docker.io -y

docker run \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITHUB_CLIENT_ID=${DRONE_GITHUB_CLIENT_ID} \
  --env=DRONE_GITHUB_CLIENT_SECRET=${DRONE_GITHUB_CLIENT_SECRET} \
  --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \
  --env=DRONE_SERVER_HOST=${DRONE_SERVER_HOST} \
  --env=DRONE_SERVER_PROTO=https \
  --publish=80:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:2

docker run --detach \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_RPC_PROTO=https \
  --env=DRONE_RPC_HOST=${DRONE_SERVER_HOST} \
  --env=DRONE_RPC_SECRET=${DRONE_RPC_SECRET} \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=prod \
  --publish=3000:3000 \
  --restart=always \
  --name=runner \
  drone/drone-runner-docker:1
