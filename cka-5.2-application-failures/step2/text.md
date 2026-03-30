## Fix ImagePullBackOff

The pod `image-pod` cannot start because it references a non-existent image tag `nginx:v999.999`.

### Task

1. Diagnose the issue
2. Fix the pod to use a valid image (`nginx:1.25`)

```bash
# Diagnose
kubectl get pod image-pod -n practice
kubectl describe pod image-pod -n practice | grep -A5 "Events:"
# Look for: "Failed to pull image"
```

<details>
<summary>Hint: Fixing ImagePullBackOff</summary>

```bash
kubectl delete pod image-pod -n practice
kubectl run image-pod --image=nginx:1.25 -n practice
```
</details>
