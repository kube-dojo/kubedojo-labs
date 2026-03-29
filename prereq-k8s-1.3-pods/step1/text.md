## Step 1: Create a Pod Imperatively

The fastest way to create a pod is with `kubectl run`.

### Create a simple pod

```bash
kubectl run nginx --image=nginx
```

Check that it's running:

```bash
kubectl get pods
```

You should see the `nginx` pod with status `Running` (it may take a few seconds to pull the image).

Watch it in real time:

```bash
kubectl get pods -w
```

Press `Ctrl+C` to stop watching.

### Specify an image version

Always use explicit image tags in real work — never rely on `:latest`:

```bash
kubectl run redis --image=redis:7.2
```

### Your task

Create a pod named `web` using the `nginx:1.25` image.

<details>
<summary>Hint</summary>

```bash
kubectl run web --image=nginx:1.25
```

Then verify:

```bash
kubectl get pod web
```
</details>
