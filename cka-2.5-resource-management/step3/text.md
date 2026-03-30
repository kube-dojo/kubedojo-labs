## Pod Priority Classes

PriorityClasses define scheduling priority. Higher-priority pods can preempt lower-priority ones when resources are scarce.

### Task

Create a PriorityClass named `high-priority` with:

- Value: `1000000`
- Global default: `false`
- Description: `"High priority for critical workloads"`

```bash
# PriorityClasses are cluster-scoped (no namespace)
cat > /root/priority.yaml << 'EOF'
# Write your PriorityClass YAML here
EOF
kubectl apply -f /root/priority.yaml
```

Verify:
```bash
kubectl get priorityclass high-priority
```

<details>
<summary>Hint: PriorityClass YAML</summary>

```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
description: "High priority for critical workloads"
```
</details>
