## ExternalName Services

ExternalName services map a service to an external DNS name. They do not use selectors or define ports. Instead, they return a CNAME record pointing to the specified external host.

### Task

1. Create an ExternalName service named `external-api` in the `practice` namespace that maps to `api.example.com`
2. Verify the service configuration
3. Create a second ExternalName service named `external-db` mapping to `db.example.com`

```bash
# Check ExternalName resolution behavior
kubectl get svc external-api -n practice -o yaml
```

Verify both services exist:

```bash
kubectl get svc -n practice
```

<details>
<summary>Hint: ExternalName YAML</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-api
  namespace: practice
spec:
  type: ExternalName
  externalName: api.example.com
```

Or imperatively:

```bash
kubectl create service externalname external-api --external-name=api.example.com -n practice
```
</details>
