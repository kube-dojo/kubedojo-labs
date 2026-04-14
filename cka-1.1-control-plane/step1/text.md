# Identify Control Plane Components

On kubeadm clusters, the control plane runs as **static pods**. Their manifests live on disk, and kubelet creates matching mirror pods in `kube-system`.

## Task

Identify the four control plane components on this node and confirm each one from two places:

1. The static pod manifest in `/etc/kubernetes/manifests/`
2. The live mirror pod in the `kube-system` namespace

You should confirm:
- `kube-apiserver`
- `etcd`
- `kube-scheduler`
- `kube-controller-manager`

Suggested commands:

```bash
ls /etc/kubernetes/manifests/
kubectl get pods -n kube-system -l tier=control-plane -o wide
kubectl get pods -n kube-system -l component=kube-apiserver
kubectl get pods -n kube-system -l component=etcd
kubectl get pods -n kube-system -l component=kube-scheduler
kubectl get pods -n kube-system -l component=kube-controller-manager
```

<details>
<summary>Hint</summary>

If a component is unhealthy, the mirror pod can still exist. Start by proving that the manifest file and the pod object are both present.
</details>
