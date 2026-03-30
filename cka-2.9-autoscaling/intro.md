## Autoscaling — HPA, Manual Scaling & VPA Concepts

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create a Horizontal Pod Autoscaler (HPA) targeting CPU utilization
- Scale deployments manually with `kubectl scale`
- Inspect pod resource usage and understand VPA concepts

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part2-workloads-scheduling/module-2.9-autoscaling/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Refer to the [HPA docs](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)

Let's begin!
