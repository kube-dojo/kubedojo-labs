## Service Troubleshooting — Missing Endpoints, Selector Mismatch & Port Issues

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Fix services with missing endpoints due to label selector mismatches
- Diagnose and fix port configuration issues (targetPort vs port)
- Troubleshoot NodePort services that are not externally accessible

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part5-troubleshooting/module-5.6-services/) for theory
- This lab takes approximately **35 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed
- Several broken services have been pre-created

Let's begin!
