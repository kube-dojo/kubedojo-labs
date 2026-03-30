## Storage Troubleshooting — PVC Pending, Mount Failures & Capacity Issues

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Diagnose and fix PVCs stuck in Pending due to mismatched StorageClasses
- Resolve access mode mismatches between PVs and PVCs
- Fix pods that fail to mount volumes due to wrong PVC names
- Address capacity issues where PVCs request more than available PVs

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part4-storage/module-4.5-troubleshooting/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Several broken resources have been pre-created for you to fix

Let's begin!
