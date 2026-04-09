#/bin/bash
set -euo pipefail


kind create cluster --config ./cluster-config.yaml
kubectl cluster-info --context kind-lab
helm install cilium ./helm/charts/cilium --values ./helm/values/cilium.yaml

echo "Removing kube-proxy DaemonSet..."
kubectl delete ds kube-proxy -n kube-system --ignore-not-found

echo "Removing kube-proxy ConfigMap..."
kubectl delete cm kube-proxy -n kube-system --ignore-not-found

echo "Cleaning up old iptables rules (this may take a moment)..."
kubectl -n kube-system exec -it ds/cilium -- cilium-dbg cleanup-kube-proxy-rules