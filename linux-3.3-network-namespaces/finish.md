# Congratulations!

You have completed the Linux Network Namespaces lab.

## What You Practiced

- Creating network namespaces with `ip netns add`
- Building veth pairs to connect namespaces to the host
- Assigning IP addresses and bringing up interfaces inside namespaces
- Demonstrating network isolation — the core principle behind container networking

## Key Takeaway

Every Kubernetes pod runs inside a network namespace. The CNI plugin (Calico, Cilium, Flannel) creates veth pairs and configures routing — exactly what you did manually in this lab.

## Next Steps

- Continue with **Module 3.4 — iptables** to learn about packet filtering and NAT
- Explore how **Kubernetes CNI plugins** automate namespace networking at scale

## Reference

Full curriculum module:
[Module 3.3 — Network Namespaces](https://kube-dojo.github.io/linux/foundations/networking/module-3.3-network-namespaces/)
