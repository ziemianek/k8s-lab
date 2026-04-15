#/bin/bash
set -euo pipefail

CILIUM_NS=${1:-"cilium"}

# Get the name of the control-plane container
CONTROL_PLANE_NAME=$(docker ps --filter "label=io.x-k8s.kind.role=control-plane" --format "{{.Names}}")

# Get its internal Docker IP
API_SERVER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${CONTROL_PLANE_NAME}")
API_SERVER_PORT=6443

kubectl create namespace "$CILIUM_NS"

helm install cilium ./helm/charts/cilium \
    --values ./helm/values/cilium.yaml \
    --namespace ${CILIUM_NS} \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT}
