## Gateway API — Gateway, HTTPRoute & Traffic Splitting

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Install the Gateway API CRDs and understand the resource model
- Create a Gateway and attach HTTPRoute resources for routing
- Implement weighted traffic splitting between service versions

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.5-gateway-api/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
