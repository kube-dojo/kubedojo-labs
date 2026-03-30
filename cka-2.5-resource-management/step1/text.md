## Resource Quotas

ResourceQuotas limit the total amount of resources that can be consumed in a namespace.

### Task

1. Create a namespace called `quota-test`:
   ```bash
   kubectl create namespace quota-test
   ```

2. Create a ResourceQuota named `ns-quota` in the `quota-test` namespace with:
   - Max pods: `2`
   - Max CPU requests: `500m`
   - Max memory requests: `512Mi`

3. Verify the quota:
   ```bash
   kubectl describe quota ns-quota -n quota-test
   ```

<details>
<summary>Hint: ResourceQuota YAML</summary>

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ns-quota
  namespace: quota-test
spec:
  hard:
    pods: "2"
    requests.cpu: "500m"
    requests.memory: "512Mi"
```

You can also create it imperatively:
```bash
kubectl create quota ns-quota -n quota-test \
  --hard=pods=2,requests.cpu=500m,requests.memory=512Mi
```
</details>
