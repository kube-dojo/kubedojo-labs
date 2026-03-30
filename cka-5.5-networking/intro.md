## Network Troubleshooting — DNS Failures, Unreachable Services & CNI Issues

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Diagnose and fix DNS resolution failures inside pods
- Troubleshoot services that are not reachable due to selector mismatches
- Verify pod-to-pod connectivity and diagnose networking issues
- Identify and fix NetworkPolicies that block legitimate traffic

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part5-troubleshooting/module-5.5-networking/) for theory
- This lab takes approximately **45 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Several broken networking resources have been pre-created

Let's begin!
