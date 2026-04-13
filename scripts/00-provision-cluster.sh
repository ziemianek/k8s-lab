#/bin/bash
set -euo pipefail

# Check if the --with-proxy flag is provided
for arg in "$@"; do
  if [ "$arg" == "--with-proxy" ]; then
    kind create cluster --config ../configs/cluster-config-with-proxy.yaml
    exit $?
  fi
done

kind create cluster --config ../configs/cluster-config.yaml
