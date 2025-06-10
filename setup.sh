#!/usr/bin/env bash

SERVER=192.168.1.43
AGENTS=(192.168.1.44 192.168.1.45 192.168.1.46 192.168.1.47)

k3sup install \
    --cluster \
    --ip $SERVER \
    --user dietpi \
    --k3s-channel stable \
    --merge \
    --local-path $HOME/.kube/config \
    --context homecluster

for AGENT in "${AGENTS[@]}"; do
  k3sup join --ip $AGENT --server-ip $SERVER --user dietpi
done