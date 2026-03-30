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

## Hint

Refer to the Kubernetes docs for CRD structure. The CRD should be a `CustomResourceDefinition` in apiVersion `apiextensions.k8s.io/v1`. Each property in the schema needs a `type` field. The schema must include `openAPIV3Schema` with `type: object` and `properties` under `spec`.
