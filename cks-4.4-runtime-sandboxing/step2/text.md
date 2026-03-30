# Create RuntimeClass Resources

Create RuntimeClass objects that pods can reference.

## Task

1. Create a RuntimeClass named `gvisor` with handler `runsc`:
   ```yaml
   apiVersion: node.k8s.io/v1
   kind: RuntimeClass
   metadata:
     name: gvisor
   handler: runsc
   ```
2. Create a RuntimeClass named `kata` with handler `kata-qemu`.
3. Create a pod YAML at `/root/sandboxed-pod.yaml` that references the `gvisor` RuntimeClass:
   ```yaml
   spec:
     runtimeClassName: gvisor
   ```
   (Do not apply — gVisor is not installed)
4. Save all RuntimeClass definitions to `/root/runtimeclasses.yaml`.

## Hint

The `handler` must match the container runtime configuration on the node. Without the actual runtime installed, pods referencing these RuntimeClasses will fail to schedule.
