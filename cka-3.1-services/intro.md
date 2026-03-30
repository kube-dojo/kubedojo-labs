## Services — ClusterIP, NodePort, LoadBalancer & ExternalName

Welcome to this hands-on lab from [KubeDojo](https://kube-dojo.github.io/) — free, open-source cloud native education.

You have a real Kubernetes cluster with one control plane node ready to use.

### Objectives

In this lab you will:

- Create ClusterIP services for internal pod-to-pod communication
- Expose applications externally using NodePort services
- Configure LoadBalancer services and understand pending states
- Map external DNS names using ExternalName services

### Before You Start

- Read the [module page](https://kube-dojo.github.io/k8s/cka/part3-services-networking/module-3.1-services/) for theory
- This lab takes approximately **40 minutes**
- `kubectl` is already configured and ready
- Alias `k=kubectl` is set up for speed

Let's begin!
