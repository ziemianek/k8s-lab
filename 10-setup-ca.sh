#/bin/bash
set -euo pipefail

# cluster name is first argument or "" (kind) if argument not provided
CLUSTER_NAME=${1:-""}

NODES=$(kind get nodes --name "$CLUSTER_NAME")
for NODE in $NODES; do
  docker exec "$NODE" update-ca-certificates
  docker exec "$NODE" touch /etc/containerd/certs.d/hosts.toml
  docker exec "$NODE" tee /etc/containerd/certs.d/hosts.toml > /dev/null <<EOF
server = "https://*"

[host."https://*"]
  capabilities = ["pull", "resolve"]
  ca = "/etc/containerd/certs.d/ca.crt"
EOF
  docker exec "$NODE" pkill containerd
done