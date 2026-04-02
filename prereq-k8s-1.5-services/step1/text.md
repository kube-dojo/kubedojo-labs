## Step 1: Expose a Deployment

A Service provides a stable network endpoint for a set of pods.

### Your task
Expose the `web` deployment (pre-created during setup) as a Service named `web-svc` on port `80`.

<details>
<summary>Hint</summary>

```bash
kubectl expose deployment web --name=web-svc --port=80 --target-port=80
```
</details>
