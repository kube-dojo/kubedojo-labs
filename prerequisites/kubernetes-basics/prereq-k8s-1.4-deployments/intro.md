## Deployments — Managing Applications

In the real world, you almost never create pods directly. Instead, you use a **Deployment** — a higher-level resource that manages pods for you. Deployments handle scaling, rolling updates, and rollbacks automatically.

### What You'll Learn

- Create a Deployment with `kubectl create deployment`
- Scale up and down with `kubectl scale`
- Update the container image with `kubectl set image`
- Roll back to a previous version with `kubectl rollout undo`

### Before You Start

If you haven't read the theory yet, check out [Module 1.4: Deployments](https://kube-dojo.github.io/prerequisites/kubernetes-basics/module-1.4-deployments/) on KubeDojo.

This lab takes about **30 minutes**. Type the commands yourself — muscle memory is the goal.

Let's go!
