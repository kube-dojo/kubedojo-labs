## Pods — Multi-container Patterns & Troubleshooting

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create multi-container pods using the sidecar pattern
- Use init containers to control startup ordering
- Configure CPU and memory requests and limits
- Diagnose and fix common pod failures (CrashLoopBackOff, ImagePullBackOff)

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part2-workloads-scheduling/module-2.1-pods/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
