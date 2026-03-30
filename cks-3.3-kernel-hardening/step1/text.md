# Configure Kernel Sysctl Parameters for Security

Kubernetes allows setting safe sysctl parameters on pods. Unsafe sysctls require explicit kubelet configuration.

## Task

1. Create a pod named `sysctl-pod` in `kernel-lab` with safe sysctl settings:
   ```yaml
   securityContext:
     sysctls:
     - name: net.ipv4.ping_group_range
       value: "0 65535"
   ```
2. Save the list of safe sysctls (allowed by default) to `/root/safe-sysctls.txt`.
3. Save the list of common unsafe sysctls that are relevant to security to `/root/unsafe-sysctls.txt`.
4. Check the current kernel parameters on the node and save security-relevant ones to `/root/node-sysctls.txt`:
   - `net.ipv4.ip_forward`
   - `kernel.panic`
   - `net.ipv4.conf.all.send_redirects`

## Hint

Safe sysctls are namespaced and cannot affect other pods. Use `sysctl -a` on the node to read kernel parameters.
