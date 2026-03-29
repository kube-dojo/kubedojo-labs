## Services — Stable Networking

Pods are ephemeral — they get new IP addresses every time they restart. A **Service** gives your pods a stable IP and DNS name that never changes, even as pods come and go behind it.

### What You'll Learn

- Create a ClusterIP service to expose a deployment inside the cluster
- Test connectivity to a service using `curl`
- Create a NodePort service to expose a deployment outside the cluster

### Before You Start

If you haven't read the theory yet, check out [Module 1.5: Services](https://kube-dojo.github.io/prerequisites/kubernetes-basics/module-1.5-services/) on KubeDojo.

This lab takes about **25 minutes**. Type the commands yourself — muscle memory is the goal.

Let's go!
