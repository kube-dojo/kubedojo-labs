## Application Failures — CrashLoopBackOff, ImagePull, OOMKill & Readiness

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Diagnose and fix a pod stuck in CrashLoopBackOff due to a bad command
- Fix ImagePullBackOff caused by a wrong image name
- Resolve OOMKilled by increasing memory limits
- Fix a failing readiness probe that prevents traffic from reaching a pod

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part5-troubleshooting/module-5.2-application-failures/) for theory
- This lab takes approximately **45 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Four broken pods have been pre-created for you to fix

Let's begin!
