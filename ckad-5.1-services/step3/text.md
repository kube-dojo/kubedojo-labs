# DNS Resolution and Headless Services

## Task

1. Create a headless Service named `web-headless` for the `web` deployment (ClusterIP set to None):
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: web-headless
     namespace: svc-lab
   spec:
     clusterIP: None
     selector:
       app: web
     ports:
     - port: 80
       targetPort: 80
   ```
2. Verify it has no ClusterIP:
   ```
   kubectl get svc web-headless -n svc-lab -o jsonpath='{.spec.clusterIP}'
   ```
3. Test DNS resolution — a headless service returns individual pod IPs:
   ```
   kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n svc-lab -- nslookup web-headless.svc-lab.svc.cluster.local
   ```
4. Save "None" to `/root/headless-ip.txt`.

## Hint

Headless Services (`clusterIP: None`) return pod IPs directly via DNS instead of a virtual IP. Useful for StatefulSets.
