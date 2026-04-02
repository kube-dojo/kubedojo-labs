# Create a Custom CRD

A CRD manifest defines a new API resource type. Key fields include:

- `group` — the API group (e.g., `kubedojo.io`)
- `names` — plural, singular, kind, shortNames
- `scope` — `Namespaced` or `Cluster`
- `schema` — OpenAPI v3 schema for validation

## Task

Create and apply a CRD with the following specification:

- **Group:** `kubedojo.io`
- **Kind:** `Backup`
- **Plural:** `backups`
- **Singular:** `backup`
- **Scope:** Namespaced
- **Version:** `v1`
- **Schema properties:** `schedule` (string), `target` (string), `retention` (integer)

<details>
<summary>Hint</summary>

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: backups.kubedojo.io
spec:
  group: kubedojo.io
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                schedule: {type: string}
                target: {type: string}
                retention: {type: integer}
  scope: Namespaced
  names:
    plural: backups
    singular: backup
    kind: Backup
```
</details>