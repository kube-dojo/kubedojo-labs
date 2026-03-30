## PersistentVolumes & PersistentVolumeClaims — Create, Bind & Reclaim

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create PersistentVolumes (PVs) with different capacities and access modes
- Create PersistentVolumeClaims (PVCs) and understand binding rules
- Mount PVCs in pods to persist data across pod restarts
- Configure and test different reclaim policies (Retain, Delete)

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part4-storage/module-4.2-pv-pvc/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
