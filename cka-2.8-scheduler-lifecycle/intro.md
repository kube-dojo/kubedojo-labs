## Scheduler & Pod Lifecycle

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Observe pod lifecycle phases (Pending, Running, Succeeded, Failed)
- Configure liveness and readiness probes for health checking
- Explore priority-based preemption scheduling

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part2-workloads-scheduling/module-2.8-scheduler-lifecycle/) for theory
- This lab takes approximately **30 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Refer to the [Pod lifecycle docs](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)

Let's begin!
