# Congratulations!

You have completed the iptables Firewall and NAT lab.

## What You Practiced

- Listing and understanding iptables chains and tables
- Creating DROP rules to block traffic on specific ports
- Setting up DNAT rules for port forwarding
- Persisting firewall rules with `iptables-save` and `iptables-restore`

## Key Takeaway

Kubernetes kube-proxy programs iptables NAT rules for every Service. When you run `iptables -t nat -L` on a Kubernetes node, you will see hundreds of rules created by kube-proxy — now you know how to read them.

## Next Steps

- Explore **nftables** — the modern replacement for iptables
- Study how **kube-proxy** implements Kubernetes Services using iptables rules
- Investigate **IPVS mode** as an alternative to iptables for large clusters

## Reference

Full curriculum module:
[Module 3.4 — iptables](https://kube-dojo.github.io/linux/foundations/networking/module-3.4-iptables/)
