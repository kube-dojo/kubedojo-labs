## Volumes — emptyDir, hostPath & Projected Volumes

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Use emptyDir volumes for inter-container data sharing and temporary storage
- Mount host filesystem paths into pods using hostPath volumes
- Combine ConfigMaps, Secrets, and downward API into projected volumes

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part4-storage/module-4.1-volumes/) for theory
- This lab takes approximately **35 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
