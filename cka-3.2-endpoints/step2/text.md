## Manual Endpoints for External Services

Sometimes you need a Kubernetes service to point to an IP address outside the cluster. You can achieve this by creating a service without a selector and manually defining an Endpoints object.

### Task

Create a service named `external-database` in the `practice` namespace that points to an external IP `10.0.0.100` on port `5432` (simulating an external PostgreSQL database):

1. Create a service **without** a selector, exposing port **5432**
2. Create a matching Endpoints object with the same name pointing to `10.0.0.100:5432`
3. Verify the endpoint is correctly associated

```bash
# After creating both resources, verify the endpoint
kubectl get endpoints external-database -n practice
kubectl describe svc external-database -n practice
```

<details>
<summary>Hint: Manual Endpoints YAML</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-database
  namespace: practice
spec:
  ports:
  - port: 5432
    targetPort: 5432
---
apiVersion: v1
kind: Endpoints
metadata:
  name: external-database
  namespace: practice
subsets:
  - addresses:
    - ip: 10.0.0.100
    ports:
    - port: 5432
```

The key is that the Endpoints object name must match the Service name exactly.
</details>
