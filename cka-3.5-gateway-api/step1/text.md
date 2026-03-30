## Install Gateway API and Create a Gateway

The Gateway API is a collection of CRDs that provide an expressive, extensible, and role-oriented way to model service networking. It separates concerns: infrastructure providers manage GatewayClass, cluster operators manage Gateway, and developers manage Routes.

### Task

1. Install the Gateway API CRDs (standard channel)
2. Create a GatewayClass named `lab-gateway-class` with controller name `example.com/gateway-controller`
3. Create a Gateway named `lab-gateway` in the `practice` namespace using the `lab-gateway-class`, listening on port **80** for HTTP traffic

```bash
# Install Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml

# Verify CRDs are installed
kubectl get crd | grep gateway
```

Create the GatewayClass and Gateway:

```bash
# Verify the resources
kubectl get gatewayclass
kubectl get gateway -n practice
```

<details>
<summary>Hint: Gateway API resources</summary>

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: lab-gateway-class
spec:
  controllerName: example.com/gateway-controller
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: lab-gateway
  namespace: practice
spec:
  gatewayClassName: lab-gateway-class
  listeners:
  - name: http
    protocol: HTTP
    port: 80
```

Note: Without a real controller implementation, the Gateway will not become programmed, but the resources will be created correctly.
</details>
