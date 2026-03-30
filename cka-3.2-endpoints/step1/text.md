## EndpointSlices and Automatic Endpoints

When you create a service with a selector, Kubernetes automatically creates EndpointSlice objects that track the IP addresses of matching pods.

### Task

1. Inspect the existing `web` service and its EndpointSlices in the `practice` namespace
2. Scale the deployment to **5** replicas and observe the EndpointSlice update
3. Create a label on the file `/root/endpoint-count.txt` containing the number of endpoints after scaling

```bash
# View the service
kubectl get svc web -n practice

# View EndpointSlices (the modern replacement for Endpoints)
kubectl get endpointslices -n practice -l kubernetes.io/service-name=web

# View detailed endpoint information
kubectl get endpointslices -n practice -l kubernetes.io/service-name=web -o yaml
```

Scale and record the count:

```bash
kubectl scale deployment web -n practice --replicas=5
kubectl wait --for=condition=Ready pod -l app=web -n practice --timeout=60s

# Count endpoints and save to file
ENDPOINT_COUNT=$(kubectl get endpointslices -n practice -l kubernetes.io/service-name=web -o jsonpath='{.items[0].endpoints[*].addresses[*]}' | wc -w)
echo "$ENDPOINT_COUNT" > /root/endpoint-count.txt
```

<details>
<summary>Hint: EndpointSlice inspection</summary>

```bash
# EndpointSlices replaced the older Endpoints resource
# They are auto-managed by the endpoint slice controller
kubectl get endpointslices -n practice -o wide

# The legacy Endpoints object is also still populated
kubectl get endpoints web -n practice
```
</details>
