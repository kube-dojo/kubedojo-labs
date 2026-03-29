## Step 2: Create a Pod from YAML

The imperative approach is fast, but the **declarative** approach (YAML files) is how real Kubernetes is done. YAML manifests can be version-controlled, reviewed, and reused.

### Pod manifest structure

Every Kubernetes manifest has four top-level fields:

```yaml
apiVersion: v1          # API version for this resource type
kind: Pod               # What type of resource
metadata:               # Name, labels, annotations
  name: example
spec:                   # The desired state
  containers:
  - name: example
    image: busybox
    command: ["sleep", "3600"]
```

### Apply a manifest

Once you write the YAML, apply it:

```bash
kubectl apply -f /path/to/file.yaml
```

### Your task

1. Create a file at `/root/api-pod.yaml` with a Pod manifest:
   - **Name**: `api`
   - **Image**: `busybox`
   - **Command**: `sleep 3600` (keeps the container alive)

2. Apply it with `kubectl apply -f`.

<details>
<summary>Hint</summary>

Create the file:

```bash
cat <<EOF > /root/api-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: api
spec:
  containers:
  - name: api
    image: busybox
    command: ["sleep", "3600"]
EOF
```

Apply it:

```bash
kubectl apply -f /root/api-pod.yaml
```

Verify:

```bash
kubectl get pod api
```
</details>
