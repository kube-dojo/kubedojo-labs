## Step 2: Labels and Versions

Labels are metadata tags. They are essential for identifying, grouping, and selecting resources.

### Your task
Create a pod named `secure-pod` in the `default` namespace with:
- Image: `nginx:1.25`
- Label: `app=secure`

<details>
<summary>Hint</summary>

```bash
kubectl run secure-pod --image=nginx:1.25 --labels="app=secure"
```
</details>
