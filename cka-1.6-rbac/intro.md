# RBAC (Role-Based Access Control)

RBAC is a key security mechanism in Kubernetes that controls who can do what in the cluster. It is a heavily tested topic on the CKA exam.

In this lab you will:

- Create Roles and RoleBindings (namespace-scoped)
- Create ClusterRoles (cluster-wide)
- Test access with `kubectl auth can-i`
- Work with ServiceAccounts and bind roles to them

**What you will learn:**
- The difference between Role/ClusterRole and RoleBinding/ClusterRoleBinding
- How to define permissions with verbs and resources
- How to test authorization decisions
- How to bind roles to ServiceAccounts

**Time:** 45 minutes

**Curriculum module:** [CKA Part 1 - RBAC](https://kube-dojo.github.io/k8s/cka/part1-cluster-architecture/module-1.6-rbac/)
