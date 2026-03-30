## DaemonSets & StatefulSets

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create a DaemonSet that runs one pod on every node
- Deploy a StatefulSet with ordered, stable pod identities
- Configure a headless service for StatefulSet DNS resolution

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part2-workloads-scheduling/module-2.3-daemonsets-statefulsets/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
