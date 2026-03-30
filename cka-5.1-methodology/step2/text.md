## Using kubectl debug

`kubectl debug` creates ephemeral containers in running pods or creates a copy of a pod with modified settings. This is useful when pods lack debugging tools.

### Task

1. Use `kubectl debug` to create an ephemeral debug container in the `debug-target` pod
2. From the debug container, check the nginx process and network configuration
3. Create a debug copy of `debug-target` with a different image for troubleshooting

```bash
# Method 1: Ephemeral container (attaches to existing pod)
kubectl debug debug-target -n practice -it --image=busybox:1.36 --target=debug-target -- sh
# Inside: ps aux, wget -qO- localhost, ip addr, exit

# Method 2: Copy pod with different image
kubectl debug debug-target -n practice -it --image=busybox:1.36 --copy-to=debug-copy --share-processes -- sh
# Inside: ps aux (can see nginx processes), exit
```

Verify the debug copy exists:

```bash
kubectl get pod debug-copy -n practice
```

<details>
<summary>Hint: kubectl debug options</summary>

```bash
# Ephemeral container (added to running pod, no restart):
kubectl debug <pod> -it --image=busybox:1.36 --target=<container>

# Copy with shared process namespace:
kubectl debug <pod> -it --copy-to=debug-copy --share-processes --image=busybox:1.36

# Copy with modified command:
kubectl debug <pod> -it --copy-to=debug-copy --image=busybox:1.36 -- sh
```
</details>
