## StatefulSet Headless Service

A headless service (clusterIP: None) is required for StatefulSets. It creates DNS entries for each pod in the form `<pod-name>.<service-name>.<namespace>.svc.cluster.local`.

### Task

1. Verify the headless service `sts-svc` exists and has `clusterIP: None`:
   ```bash
   kubectl get svc sts-svc -n practice -o jsonpath='{.spec.clusterIP}'
   ```

2. Verify DNS resolution from inside a pod:
   ```bash
   kubectl run dns-test --image=busybox:1.36 -n practice --rm -it --restart=Never -- \
     nslookup web-sts-0.sts-svc.practice.svc.cluster.local
   ```

3. If the headless service does not exist or has a cluster IP assigned, recreate it:
   ```bash
   kubectl delete svc sts-svc -n practice --ignore-not-found
   ```

   Then create it properly as a headless service with `clusterIP: None` and a selector matching `app: web-sts`.

<details>
<summary>Hint: Headless service YAML</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: sts-svc
  namespace: practice
spec:
  clusterIP: None
  selector:
    app: web-sts
  ports:
  - port: 80
    targetPort: 80
```

The key is `clusterIP: None` — this makes it a headless service.
</details>
