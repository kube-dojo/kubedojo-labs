# Verify Cluster Health

The first thing to do in any CKA exam scenario is confirm your cluster is working. Use these commands to check:

- `kubectl cluster-info` — shows the API server and CoreDNS endpoints
- `kubectl get nodes` — lists nodes and their Ready/NotReady status
- `kubectl get componentstatuses` (or `kubectl get cs`) — checks etcd, scheduler, controller-manager

## Task

1. Run `kubectl cluster-info` to confirm the API server is running.
2. Run `kubectl get nodes` to see all nodes.
3. Count the number of nodes in the cluster and save that number to `/root/node-count.txt`.

For example, if there are 2 nodes, the file should contain just `2`.

## Hint

Use `kubectl get nodes --no-headers | wc -l` to count nodes programmatically.
