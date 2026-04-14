# Modify API Server Flags

The API server static pod manifest is the source of truth for its runtime flags. When you edit `/etc/kubernetes/manifests/kube-apiserver.yaml`, kubelet restarts the API server automatically.

## Task

Add the flag `--event-ttl=2h0m0s` to the API server manifest, then prove that the running API server process picked it up.

Recommended flow:

1. Back up `/etc/kubernetes/manifests/kube-apiserver.yaml` to `/var/tmp/kube-apiserver.before-step3.yaml`
2. Edit the manifest and add `--event-ttl=2h0m0s` under the `command` list
3. Wait for the API server static pod to become ready again
4. Confirm the flag from the running process with `/proc/<pid>/cmdline`

Useful commands:

```bash
cp /etc/kubernetes/manifests/kube-apiserver.yaml /var/tmp/kube-apiserver.before-step3.yaml
vi /etc/kubernetes/manifests/kube-apiserver.yaml
kubectl get pods -n kube-system -l component=kube-apiserver
pgrep -af kube-apiserver
tr '\0' '\n' < /proc/<pid>/cmdline
```

<details>
<summary>Hint</summary>

Add the flag as its own list item in the `command:` section. Do not change existing certificate, port, or etcd flags.
</details>
