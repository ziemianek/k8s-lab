#!/bin/bash
set -euo pipefail

WITH_PROXY=false

# Check if the --with-proxy flag is provided
for arg in "$@"; do
  if [ "$arg" == "--with-proxy" ]; then
    WITH_PROXY=true
    break 
  fi
done

if [ "$WITH_PROXY" = true ]; then
  ./scripts/00-provision-cluster.sh --with-proxy
  ./scripts/10-setup-ca.sh
else
  ./scripts/00-provision-cluster.sh
fi

./scripts/20-setup-cilium.sh
