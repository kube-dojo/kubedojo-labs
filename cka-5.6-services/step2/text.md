## Fix Port Mismatch

The service `web-svc` has endpoints but traffic fails because the `targetPort` is 8080 while nginx listens on port 80.

### Task

1. Diagnose the port mismatch
2. Fix the service targetPort to match the pod's actual listening port

```bash
# Service has endpoints (selector matches)
kubectl get endpoints web-svc -n practice

# But traffic fails
kubectl run test --image=curlimages/curl --rm -it --restart=Never -n practice -- curl -s --max-time 3 http://web-svc || echo "Connection failed"

# Check what port the pod listens on
kubectl get pod web-app -n practice -o jsonpath='{.spec.containers[0].ports[0].containerPort}'
# Shows: 80 — but service targetPort is 8080
```

<details>
<summary>Hint: Fix targetPort</summary>

```bash
kubectl patch svc web-svc -n practice --type='json' -p='[{"op":"replace","path":"/spec/ports/0/targetPort","value":80}]'
```
</details>
