## Pod Resource Requests and Limits

Resource requests tell the scheduler how much CPU and memory a pod needs. Limits cap the maximum a container can use.

### Task

Create a pod named `resource-pod` in the `practice` namespace with:

- Image: `nginx:1.25`
- Resource **requests**: CPU `100m`, memory `64Mi`
- Resource **limits**: CPU `200m`, memory `128Mi`

```bash
# You can use --dry-run to generate a base YAML and edit it
kubectl run resource-pod --image=nginx:1.25 -n practice --dry-run=client -o yaml > /root/resource-pod.yaml
```

<details>
<summary>Hint: Resources spec</summary>

Add a `resources` block to the container spec:

```yaml
containers:
- name: resource-pod
  image: nginx:1.25
  resources:
    requests:
      cpu: "100m"
      memory: "64Mi"
    limits:
      cpu: "200m"
      memory: "128Mi"
```
</details>
