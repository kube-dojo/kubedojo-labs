## Control Plane Troubleshooting — API Server, etcd & Scheduler

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Check control plane component health using multiple methods
- Diagnose and fix API server configuration issues via static pod manifests
- Investigate etcd health and backup/restore procedures
- Fix scheduler misconfigurations that prevent pod scheduling

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part5-troubleshooting/module-5.3-control-plane/) for theory
- This lab takes approximately **45 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
