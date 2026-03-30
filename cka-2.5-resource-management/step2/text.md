## Limit Ranges

A LimitRange sets default resource requests/limits for containers in a namespace that don't specify their own.

### Task

Create a LimitRange named `default-limits` in the `quota-test` namespace with:

- Default request: CPU `100m`, memory `64Mi`
- Default limit: CPU `200m`, memory `128Mi`
- Max limit: CPU `500m`, memory `512Mi`

```bash
# LimitRanges cannot be created imperatively, use YAML
cat > /root/limitrange.yaml << 'EOF'
# Write your LimitRange YAML here
EOF
kubectl apply -f /root/limitrange.yaml
```

Verify:
```bash
kubectl describe limitrange default-limits -n quota-test
```

<details>
<summary>Hint: LimitRange YAML</summary>

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: quota-test
spec:
  limits:
  - default:
      cpu: "200m"
      memory: "128Mi"
    defaultRequest:
      cpu: "100m"
      memory: "64Mi"
    max:
      cpu: "500m"
      memory: "512Mi"
    type: Container
```
</details>
