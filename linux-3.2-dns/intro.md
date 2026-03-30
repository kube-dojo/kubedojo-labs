# DNS Resolution and Troubleshooting

The Domain Name System (DNS) is the phone book of the internet — it translates human-readable names like `kubernetes.io` into IP addresses that computers use to route traffic. In this lab, you will configure local name resolution, query DNS records with `dig` and `nslookup`, and troubleshoot common DNS issues.

Understanding DNS is critical for Kubernetes work, where every Service gets a DNS name (e.g., `my-svc.my-namespace.svc.cluster.local`) managed by CoreDNS.

## What You Will Learn

- How `/etc/hosts` and `/etc/resolv.conf` control local name resolution
- How to query DNS record types (A, AAAA, MX, NS, CNAME) with `dig`
- How to identify and configure nameservers
- How to troubleshoot DNS resolution failures

## Prerequisites

- Basic Linux command-line familiarity
- Completed Module 3.1 (TCP/IP) or equivalent knowledge

## Reference

This lab accompanies the KubeDojo curriculum module:
[Module 3.2 — DNS](https://kube-dojo.github.io/linux/foundations/networking/module-3.2-dns/)
