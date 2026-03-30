# Create NodePort Services

## Task

1. Create a NodePort service named `web-nodeport` for the `web` deployment on port 80:
   ```
   kubectl expose deployment web --name=web-nodeport --port=80 --target-port=80 --type=NodePort -n svc-lab
   ```
2. Find the NodePort assigned:
   ```
   kubectl get svc web-nodeport -n svc-lab -o jsonpath='{.spec.ports[0].nodePort}'
   ```
   Save it to `/root/node-port.txt`.
3. Test access via the node IP and NodePort:
   ```
   curl localhost:<nodeport>
   ```

## Hint

NodePort Services expose a port on every node (30000-32767 range). Access via `<NodeIP>:<NodePort>`.
