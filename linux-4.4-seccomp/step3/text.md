# Apply to Containers

seccomp profiles are applied at container runtime. Both Docker and Kubernetes support custom profiles.

## Docker

```bash
# Apply a custom seccomp profile
docker run --security-opt seccomp=/path/to/profile.json alpine sh

# Run with no seccomp profile (unconfined — dangerous)
docker run --security-opt seccomp=unconfined alpine sh

# Use the default Docker profile (applied automatically)
docker run alpine sh
```

## Kubernetes

In Kubernetes, seccomp profiles are specified in the pod's `securityContext`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-demo
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault  # Use container runtime's default profile
  containers:
  - name: app
    image: nginx
    securityContext:
      seccompProfile:
        type: Localhost
        localhostProfile: profiles/custom-profile.json
        # File must exist on the node at:
        # /var/lib/kubelet/seccomp/profiles/custom-profile.json
```

## Kubernetes seccomp Profile Types

| Type | Behaviour |
|------|-----------|
| `RuntimeDefault` | Use the container runtime's built-in default profile |
| `Localhost` | Load a custom profile from the node's filesystem |
| `Unconfined` | No seccomp filtering (not recommended) |

## Task

1. If Docker is available, test the profile:
   ```bash
   docker run --rm --security-opt seccomp=~/seccomp-profile.json alpine chmod 777 /tmp
   ```
   This should fail because `chmod` is blocked.

2. Whether or not Docker is available, create a Kubernetes pod manifest at `~/k8s-seccomp.yaml` that:
   - Deploys an nginx pod named `seccomp-demo`
   - Applies the `RuntimeDefault` seccomp profile at the pod level
   - Applies a custom `Localhost` profile at the container level with path `profiles/no-chmod.json`

<details>
<summary>Refer to: Kubernetes seccomp documentation</summary>
See the Kubernetes documentation on <a href="https://kubernetes.io/docs/tutorials/security/seccomp/">Restrict a Container's Syscalls with seccomp</a>. The <code>localhostProfile</code> path is relative to <code>/var/lib/kubelet/seccomp/</code> on the node.
</details>
