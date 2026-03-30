## ClusterIP Services

ClusterIP is the default service type. It provides a stable internal IP address that other pods within the cluster can use to reach a set of pods matched by a label selector.

### Task

Create a ClusterIP service named `backend-svc` in the `practice` namespace that:

1. Selects pods with label `app=web,tier=backend`
2. Exposes port **80** targeting port **80** on the pods
3. Uses the default ClusterIP type

```bash
# Check what pods are available
kubectl get pods -n practice --show-labels
```

After creating the service, verify connectivity from within the cluster:

```bash
# Test with a temporary pod
kubectl run test-curl --image=curlimages/curl --rm -it --restart=Never -n practice -- curl -s backend-svc.practice.svc.cluster.local
```

<details>
<summary>Hint: Creating ClusterIP services</summary>

You can use `kubectl expose` or create YAML directly:

```bash
kubectl expose pod web-backend -n practice --name=backend-svc --port=80 --target-port=80
```

Or declaratively:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend-svc
  namespace: practice
spec:
  selector:
    app: web
    tier: backend
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```
</details>
