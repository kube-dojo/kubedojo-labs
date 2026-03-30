# Network Policies

NetworkPolicies are a key CKS topic (Cluster Setup domain, 10%). They control traffic flow between pods and to/from external endpoints.

## What You Will Learn

- Default deny-all policies for zero-trust networking
- Allow specific traffic using pod and namespace selectors
- Egress restrictions to limit outbound traffic
- Multi-tier application network segmentation

## Prerequisites

- A cluster with a CNI that supports NetworkPolicy (Calico, Cilium, etc.)

> **Study guide**: [KubeDojo Network Policies](https://kube-dojo.github.io/k8s/cks/part1/module-1.1-network-policies/)
