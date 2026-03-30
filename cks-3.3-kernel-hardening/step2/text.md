# Manage Linux Capabilities in Pods

Linux capabilities divide root privileges into distinct units. Containers should only have the capabilities they need.

## Task

1. Create a pod named `no-caps` in `kernel-lab` that drops ALL capabilities:
   ```yaml
   securityContext:
     capabilities:
       drop: ["ALL"]
   ```
2. Create a pod named `net-caps` in `kernel-lab` that drops ALL then adds only `NET_BIND_SERVICE`:
   ```yaml
   securityContext:
     capabilities:
       drop: ["ALL"]
       add: ["NET_BIND_SERVICE"]
   ```
3. List the default capabilities granted to containers and save to `/root/default-caps.txt`.
4. Test what capabilities each pod has and save to `/root/caps-comparison.txt`.

## Hint

Use `kubectl exec <pod> -- cat /proc/1/status | grep Cap` to see capability sets. Use `capsh --decode=<hex>` to decode.
