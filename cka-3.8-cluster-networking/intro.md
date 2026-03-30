## Cluster Networking — Pod-to-Pod, Pod-to-Service & iptables Rules

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Verify pod-to-pod communication using direct IP addresses
- Trace pod-to-service traffic and understand ClusterIP resolution
- Examine iptables rules created by kube-proxy for service routing

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.8-cluster-networking/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
