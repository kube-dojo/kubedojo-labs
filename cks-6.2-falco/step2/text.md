# Write Custom Falco Rules

Create custom rules to detect Kubernetes-specific security events.

## Task

1. Create a custom rules file at `/etc/falco/falco_rules.local.yaml` with these rules:
   - Detect when someone execs into a pod (`kubectl exec`)
   - Detect when `/etc/shadow` is read inside a container
   - Detect when a process writes to `/etc/` inside a container
   - Detect when a container runs as root (UID 0)
2. Each rule needs: `rule`, `desc`, `condition`, `output`, and `priority`.
3. Save a copy to `/root/custom-rules.yaml`.

## Hint

Falco conditions use fields like `evt.type`, `container`, `proc.name`, `user.uid`, `fd.name`. Use `spawned_process` macro for new processes and `open_write`/`open_read` for file access.
