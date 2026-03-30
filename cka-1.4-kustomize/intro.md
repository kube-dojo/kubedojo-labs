# Kustomize

Kustomize is built into kubectl and lets you customize Kubernetes manifests without modifying the originals. It uses a **base + overlays** pattern.

In this lab you will:

- Create a base kustomization with a deployment and service
- Add a production overlay with name prefixes and replica overrides
- Apply the kustomization to the cluster

**What you will learn:**
- How to structure a kustomization.yaml with resources
- How to create overlays with namePrefix and patches
- How to preview and apply kustomizations with kubectl

**Time:** 35 minutes

**Curriculum module:** [CKA Part 1 - Kustomize](https://kube-dojo.github.io/k8s/cka/part1-cluster-architecture/module-1.4-kustomize/)
