#!/bin/sh

set -e

IFS=',' read -r -a plugins <<< "$INPUT_PLUGINS"

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"

echo "running entrypoint command(s)"

for i in "${plugins[@]}"
do
   helm plugin install $i
done

response=$(sh -c " $*")

echo "::set-output name=response::$response"
