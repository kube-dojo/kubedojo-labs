## ConfigMap from Literal and File

ConfigMaps store non-confidential configuration data as key-value pairs.

### Task

Create a ConfigMap named `app-config` in the `practice` namespace with two literal keys:

- `APP_ENV=production`
- `LOG_LEVEL=info`

```bash
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=LOG_LEVEL=info \
  -n practice
```

Verify the data:

```bash
kubectl get configmap app-config -n practice -o yaml
kubectl describe configmap app-config -n practice
```

<details>
<summary>Hint: Other ways to create ConfigMaps</summary>

From a file:
```bash
echo "APP_ENV=production" > /tmp/config.txt
kubectl create configmap app-config --from-file=/tmp/config.txt -n practice
```

From an env file:
```bash
kubectl create configmap app-config --from-env-file=/tmp/config.txt -n practice
```
</details>
