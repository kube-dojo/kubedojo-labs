# iptables Firewall and NAT

`iptables` is the traditional Linux firewall and packet manipulation tool. It controls which network traffic is allowed, blocked, or redirected by inserting rules into kernel-level chains and tables.

In the Kubernetes world, kube-proxy uses iptables (or its successor nftables/IPVS) to implement Service routing — every ClusterIP and NodePort is backed by iptables NAT rules. Understanding iptables deeply will help you troubleshoot Service connectivity issues and understand how Kubernetes networking really works.

## What You Will Learn

- The iptables table/chain architecture (filter, nat, mangle)
- How to create rules to accept, drop, and reject traffic
- How to set up DNAT port forwarding
- How to persist rules with `iptables-save` and `iptables-restore`

## Prerequisites

- Completed Module 3.1 (TCP/IP) — understanding of ports and protocols
- Familiarity with network namespaces (Module 3.3) is helpful

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 3.4 — iptables](https://kube-dojo.github.io/linux/foundations/networking/module-3.4-iptables/)
