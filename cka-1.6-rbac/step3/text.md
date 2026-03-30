# Test Access

`kubectl auth can-i` lets you check whether a user or ServiceAccount has permission to perform an action.

**Examples:**
```bash
kubectl auth can-i get pods                                    # Can I get pods?
kubectl auth can-i get pods --as=jane                          # Can jane get pods?
kubectl auth can-i get pods --as=system:serviceaccount:ns:sa   # Can a SA get pods?
kubectl auth can-i '*' '*'                                     # Am I a cluster admin?
```

## Task

Check if the `default` ServiceAccount in the `rbac-test` namespace can get pods, and save the result (`yes` or `no`) to `/root/can-i-result.txt`.

## Hint

Run: `kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:default -n rbac-test`
