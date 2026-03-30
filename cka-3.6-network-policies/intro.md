## Network Policies — Ingress, Egress, Default Deny & Namespace Isolation

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create ingress NetworkPolicies to restrict which pods can access a service
- Configure egress policies to control outbound traffic from pods
- Implement default deny policies for zero-trust networking
- Set up namespace-level isolation using namespace selectors

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.6-network-policies/) for theory
- This lab takes approximately **45 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Note: The default CNI (Calico/Weave) must support NetworkPolicies for enforcement

Let's begin!
