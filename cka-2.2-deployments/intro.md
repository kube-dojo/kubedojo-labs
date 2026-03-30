## Deployments — Rolling Updates & Rollbacks

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Configure rolling update strategies with maxSurge and maxUnavailable
- Inspect deployment rollout history and revision annotations
- Rollback to a specific revision
- Pause and resume deployments for batched updates

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part2-workloads-scheduling/module-2.2-deployments/) for theory
- This lab takes approximately **45 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
