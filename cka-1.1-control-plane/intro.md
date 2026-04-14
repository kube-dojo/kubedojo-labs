# Control Plane Components

This lab moves beyond simple identification. You will inspect the real control plane on a kubeadm node, query etcd with `etcdctl`, change a live API server flag, recover a scheduler failure, and capture a verbose `kubectl` trace.

One fault has already been introduced for you: the scheduler's kubeconfig points at the wrong API server port. You will diagnose and recover that failure in Step 4.

In this lab you will:

- Confirm the four control plane components from static pod manifests and live mirror pods
- Query etcd directly with TLS credentials from the control plane node
- Edit the API server static pod manifest and verify the new flag in the running process
- Diagnose a scheduler failure from logs and cluster symptoms, then restore service
- Trace a `kubectl` request with `--v=8` to see the request path and response details

**What you will practice:**
- Static pod troubleshooting on kubeadm clusters
- Direct etcd inspection with `etcdctl`
- Safe control plane manifest edits and restart validation
- Control plane failure diagnosis and recovery under CKA-style conditions

**Time:** 40 minutes  
**Difficulty:** Intermediate

**Curriculum module:** [CKA Part 1 - Control Plane](https://kube-dojo.github.io/k8s/cka/part1-cluster-architecture/module-1.1-control-plane/)
