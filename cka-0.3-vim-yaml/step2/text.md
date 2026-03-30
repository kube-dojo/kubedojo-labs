# YAML Structure

YAML is whitespace-sensitive. Common mistakes include:

- **Tabs instead of spaces** — YAML only allows spaces
- **Inconsistent indentation** — child keys must be indented consistently (2 spaces is standard in K8s)
- **Missing indentation** — a child key at the wrong level

A broken YAML file has been created at `/root/broken.yaml`. It has indentation errors that prevent it from being parsed.

## Task

Fix `/root/broken.yaml` so that it is valid YAML representing a Pod with:
- `apiVersion: v1`
- `kind: Pod`
- `metadata.name: broken-pod` with label `app: test`
- `spec.containers` with one container: name `nginx`, image `nginx:1.27`, containerPort `80`

## Hint

Use `python3 -c "import yaml; yaml.safe_load(open('/root/broken.yaml'))"` to test if your YAML is valid. The key issues are indentation levels for `name` under `metadata` and `image` under the container list item.
