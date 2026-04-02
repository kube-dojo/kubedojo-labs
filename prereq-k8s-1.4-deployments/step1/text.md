## Step 1: Create a Deployment

Deployments manage a set of identical pods (replicas). They handle rolling updates and self-healing.

### Your task
Create a deployment named `webapp` with `3` replicas using the `nginx:1.25` image.

<details>
<summary>Hint</summary>

```bash
kubectl create deployment webapp --image=nginx:1.25 --replicas=3
```
</details>
