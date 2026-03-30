## Endpoints — EndpointSlices, Manual Endpoints & Headless Services

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Inspect EndpointSlices and understand how Kubernetes auto-populates them
- Create manual endpoints to point a service at an external IP address
- Configure headless services for direct pod DNS resolution

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.2-endpoints/) for theory
- This lab takes approximately **30 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
