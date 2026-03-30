## Volume Snapshots — Create & Restore from Snapshots

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Install the VolumeSnapshot CRDs and understand the snapshot resource model
- Create VolumeSnapshotClass and VolumeSnapshot resources
- Restore data from a snapshot into a new PersistentVolumeClaim

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part4-storage/module-4.4-snapshots/) for theory
- This lab takes approximately **30 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Note: Full snapshot functionality requires a CSI driver with snapshot support. This lab focuses on resource creation patterns.

Let's begin!
