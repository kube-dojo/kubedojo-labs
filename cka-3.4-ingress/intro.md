## Ingress — Controller, Rules, TLS & Path-based Routing

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Install the NGINX Ingress controller
- Configure host-based routing to direct traffic to different services
- Set up path-based routing for multiple backends behind a single host
- Configure TLS termination with a self-signed certificate

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.4-ingress/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
