# Kubernetes home lab

# Stack
- cluster: kind (on docker)
- cni: cilium with kube-proxy replacement mode on
- cd: flux

# Install
export .env
```sh
export $(grep -v '^#' .env | xargs)
```

run
```sh
./create.sh
```

```sh
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=k8s-lab \
  --branch=main \
  --path=$CLUSTER_PATH \
  --personal
```

# Useful sources
https://docs.cilium.io/en/stable/installation/kind/
https://docs.cilium.io/en/stable/network/kubernetes/kubeproxy-free/#kubeproxy-free
https://kind.sigs.k8s.io/docs/user/configuration/#networking
https://fluxcd.io/flux/get-started/