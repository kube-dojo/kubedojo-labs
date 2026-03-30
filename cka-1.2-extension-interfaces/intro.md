# Extension Interfaces: CRI, CNI, CSI

Kubernetes uses a plugin architecture with three key interfaces:

- **CRI (Container Runtime Interface)** — how Kubernetes runs containers (containerd, CRI-O)
- **CNI (Container Network Interface)** — how pods get networking (Calico, Flannel, Cilium)
- **CSI (Container Storage Interface)** — how persistent storage is provisioned

In this lab you will identify which plugins your cluster uses for each interface.

**What you will learn:**
- How to identify the container runtime
- How to find the CNI plugin configuration
- How to list storage classes and CSI drivers

**Time:** 35 minutes

**Curriculum module:** [CKA Part 1 - Extension Interfaces](https://kube-dojo.github.io/k8s/cka/part1-cluster-architecture/module-1.2-extension-interfaces/)
