## Step 3: Use Output Formats

`kubectl get` supports several output formats. Mastering these is essential for scripting and for the CKA/CKAD exams.

### Wide output

```bash
kubectl get nodes -o wide
```

Shows extra columns like IP, OS image, kernel, and container runtime.

### YAML output

```bash
kubectl get node controlplane -o yaml
```

The full resource definition — everything Kubernetes knows about this node. This is the same format you'd use in a manifest file.

### JSON output

```bash
kubectl get node controlplane -o json
```

Same data as YAML, but in JSON format. Useful for piping to `jq`.

### JSONPath — extract specific fields

JSONPath lets you pull out exactly the data you need:

```bash
kubectl get node controlplane -o jsonpath='{.metadata.name}'
```

```bash
kubectl get node controlplane -o jsonpath='{.status.addresses[0].address}'
```

### Your task

Get the **InternalIP** of the node using jsonpath and save it to:

```
/root/node-ip.txt
```

<details>
<summary>Hint</summary>

The InternalIP is in `.status.addresses`. You need the one where `type` is `InternalIP`:

```bash
kubectl get node controlplane -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}' > /root/node-ip.txt
```

Or if you know it's the first address:

```bash
kubectl get node controlplane -o jsonpath='{.status.addresses[0].address}' > /root/node-ip.txt
```
</details>
