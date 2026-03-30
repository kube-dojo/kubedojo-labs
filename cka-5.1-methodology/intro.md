## Troubleshooting Methodology — Systematic Approach, kubectl debug & describe

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Use `kubectl describe` and events to quickly identify pod issues
- Use `kubectl debug` to create ephemeral debug containers
- Apply a systematic troubleshooting methodology to diagnose and fix a broken deployment

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part5-troubleshooting/module-5.1-methodology/) for theory
- This lab takes approximately **30 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Several broken resources have been pre-created for you to diagnose

Let's begin!
