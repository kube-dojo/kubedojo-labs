# Medium Tasks — Configure RBAC and Network Policies

These tasks typically take 4-6 minutes on the exam.

## Task

1. Create a Role named `pod-reader` in `exam-practice` that allows `get`, `list`, `watch` on `pods`.
2. Create a RoleBinding named `exam-sa-binding` in `exam-practice` that binds the `pod-reader` role to the `exam-sa` ServiceAccount.
3. Create a NetworkPolicy named `deny-all` in `exam-practice` that denies all ingress traffic to all pods.
4. Verify the ServiceAccount can list pods: `kubectl auth can-i list pods -n exam-practice --as=system:serviceaccount:exam-practice:exam-sa` and save the result to `/root/rbac-check.txt`.

## Hint

Use `kubectl create role` and `kubectl create rolebinding` for speed. For NetworkPolicy, use an empty `podSelector` and empty `ingress` list.
