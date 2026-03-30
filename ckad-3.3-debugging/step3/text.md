# Use kubectl exec and debug for Troubleshooting

## Task

1. Create a pod named `debug-target` in `debug-lab` with image `nginx:1.25`.
2. Use `kubectl exec` to run a command inside the container:
   ```
   kubectl exec debug-target -n debug-lab -- nginx -v
   ```
   Save the nginx version to `/root/nginx-version.txt`.
3. Use `kubectl exec -it` to check the filesystem:
   ```
   kubectl exec debug-target -n debug-lab -- ls /etc/nginx/
   ```
   Save the output to `/root/nginx-config-list.txt`.
4. Check DNS resolution from inside the pod:
   ```
   kubectl exec debug-target -n debug-lab -- cat /etc/resolv.conf
   ```
   Save the nameserver to `/root/dns-server.txt`.

## Hint

`kubectl exec <pod> -- <command>` runs a command in the container. Use `-it` for interactive sessions. See Kubernetes docs: Get a Shell to a Running Container.
