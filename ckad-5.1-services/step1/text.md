# Create ClusterIP Services

## Task

1. Expose the `web` deployment with a ClusterIP service named `web-clusterip` on port 80:
   ```
   kubectl expose deployment web --name=web-clusterip --port=80 --target-port=80 -n svc-lab
   ```
2. Get the ClusterIP and save it to `/root/cluster-ip.txt`:
   ```
   kubectl get svc web-clusterip -n svc-lab -o jsonpath='{.spec.clusterIP}'
   ```
3. Test connectivity from a temporary pod:
   ```
   kubectl run test-curl --image=busybox:1.36 --rm -it --restart=Never -n svc-lab -- wget -qO- web-clusterip.svc-lab.svc.cluster.local
   ```
4. Save the service type to `/root/svc-type.txt`.

## Hint

ClusterIP is the default service type. The DNS name for a service is `<service>.<namespace>.svc.cluster.local`.
