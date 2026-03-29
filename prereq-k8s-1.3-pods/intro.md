## Pods — The Atomic Unit

A **Pod** is the smallest deployable unit in Kubernetes. It's a wrapper around one or more containers that share networking and storage. Every application you run on Kubernetes runs inside a pod.

### What You'll Learn

- Create pods using `kubectl run` (imperative)
- Create pods from YAML manifests (declarative)
- Inspect pods with `kubectl describe` and `kubectl logs`
- Delete pods and verify cleanup

### Before You Start

If you haven't read the theory yet, check out [Module 1.3: Pods](https://kube-dojo.github.io/prerequisites/kubernetes-basics/module-1.3-pods/) on KubeDojo.

This lab takes about **25 minutes**. Type the commands yourself — muscle memory is the goal.

Let's go!
