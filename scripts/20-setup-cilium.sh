#/bin/bash
set -euo pipefail

CILIUM_NS=${1:-"cilium"}

# TODO: get ip dynamically
API_SERVER_IP="172.18.0.3"
API_SERVER_PORT=6443

kubectl create namespace "$CILIUM_NS"

helm install cilium ../helm/charts/cilium \
    --values ../helm/values/cilium.yaml \
    --namespace ${CILIUM_NS} \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT}
