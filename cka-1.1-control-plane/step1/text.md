# Identify Control Plane Components

On a kubeadm-provisioned cluster, control plane components run as **static pods**. Their manifests are stored in `/etc/kubernetes/manifests/`.

The kubelet watches this directory and ensures these pods are always running.

**Control plane static pods:**
- `kube-apiserver`
- `kube-controller-manager`
- `kube-scheduler`
- `etcd`

## Task

List the YAML files in `/etc/kubernetes/manifests/` and save the list to `/root/static-pods.txt`.

<details>
<summary>Hint</summary>

```bash
ls /etc/kubernetes/manifests/ > /root/static-pods.txt
```
</details>