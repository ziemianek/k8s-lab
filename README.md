https://docs.cilium.io/en/stable/installation/kind/
https://docs.cilium.io/en/stable/network/kubernetes/kubeproxy-free/#kubeproxy-free
https://kind.sigs.k8s.io/docs/user/configuration/#networking


❯ docker exec kind-control-plane ls -al /proc/self/ns/cgroup

lrwxrwxrwx 1 root root 0 Apr  9 13:42 /proc/self/ns/cgroup -> cgroup:[4026532583]
…/k8s-lab on 󰊢 main [✘!?] 
❯ docker exec kind-worker ls -al /proc/self/ns/cgroup
lrwxrwxrwx 1 root root 0 Apr  9 13:43 /proc/self/ns/cgroup -> cgroup:[4026532559]
…/k8s-lab on 󰊢 main [✘!?] 
❯ ls -al /proc/self/ns/cgroup

ls: /proc/self/ns/cgroup: No such file or directory
…/k8s-lab on 󰊢 main [✘!?] 
❯ docker run --rm --privileged --net=host --pid=host alpine ls -al /proc/self/ns/cgroup