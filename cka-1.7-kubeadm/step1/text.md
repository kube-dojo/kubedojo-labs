# Inspect Cluster Configuration

kubeadm stores the cluster configuration as a ConfigMap in the `kube-system` namespace.

**Key commands:**
```bash
kubeadm config print init-defaults      # Show default init config
kubectl get configmap -n kube-system     # List configmaps
kubectl get configmap kubeadm-config -n kube-system -o yaml   # Show kubeadm config
```

## Task

Get the kubeadm cluster configuration and save the cluster name (from the kubeconfig or node name) to `/root/cluster-name.txt`.

## Hint

Try `kubectl config view -o jsonpath='{.clusters[0].name}'` to get the cluster name from kubeconfig. Alternatively, check `kubectl get configmap kubeadm-config -n kube-system -o yaml` for the clusterName field.
