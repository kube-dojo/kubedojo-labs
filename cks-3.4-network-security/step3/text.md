# Configure Host-Level Firewall Rules

Use iptables to restrict network access to the Kubernetes node.

## Task

1. List current iptables rules and save to `/root/iptables-before.txt`.
2. Create iptables rules that:
   - Allow established connections
   - Allow SSH (port 22) from any source
   - Allow K8s API server (port 6443) from any source
   - Allow kubelet (port 10250) only from the local network
   - Save the rules to `/root/iptables-rules.txt` (the commands, not applied — do not disrupt the cluster)
3. Create `/root/firewall-best-practices.txt` with at least 4 node firewall best practices.

## Hint

Do NOT apply restrictive iptables rules directly as they may break cluster networking. Document the rules you would apply in production.
