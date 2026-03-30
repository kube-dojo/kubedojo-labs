# Linux Network Namespaces

Network namespaces are a foundational Linux kernel feature that provides network isolation. Each namespace has its own network stack — interfaces, routing table, firewall rules, and sockets — completely separate from other namespaces.

This is the exact mechanism that container runtimes (Docker, containerd) and Kubernetes use to give each pod its own network identity. Understanding namespaces at this level will demystify how container networking works.

## What You Will Learn

- How to create and manage network namespaces with `ip netns`
- How veth (virtual ethernet) pairs connect namespaces together
- How to assign IPs and configure routing inside namespaces
- How network isolation prevents cross-namespace communication without explicit configuration

## Prerequisites

- Completed Module 3.1 (TCP/IP) — understanding of IP addresses and routing
- Familiarity with `ip` command basics

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 3.3 — Network Namespaces](https://kube-dojo.github.io/linux/foundations/networking/module-3.3-network-namespaces/)
