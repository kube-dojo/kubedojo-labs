# Scheduler and Controller Manager

The **kube-scheduler** assigns pods to nodes based on resource requirements, affinity rules, and constraints.

The **kube-controller-manager** runs controllers that reconcile desired state with actual state (e.g., ReplicaSet controller, Node controller, Endpoint controller).

Both run as static pods and can be checked for health.

## Task

Check whether the scheduler and controller-manager pods are running, and save their status to `/root/cp-health.txt`. Include the pod name and status for each.

<details>
<summary>Hint</summary>

Use `kubectl get pods -n kube-system` and filter for both components:
```bash
kubectl get pods -n kube-system | grep -E 'scheduler|controller-manager' > /root/cp-health.txt
```
</details>