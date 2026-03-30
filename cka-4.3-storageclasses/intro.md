## StorageClasses — Dynamic Provisioning, Default SC & Parameters

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create StorageClasses with different provisioners and parameters
- Use dynamic provisioning to automatically create PVs from PVCs
- Configure a default StorageClass for the cluster

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part4-storage/module-4.3-storageclasses/) for theory
- This lab takes approximately **35 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
