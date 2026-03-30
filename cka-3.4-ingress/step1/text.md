## Install NGINX Ingress Controller

An Ingress resource needs a controller to function. The NGINX Ingress controller is the most widely used option.

### Task

1. Install the NGINX Ingress controller using the official manifest
2. Wait for the controller pod to be ready
3. Verify the controller is running

```bash
# Install NGINX Ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/baremetal/deploy.yaml

# Watch the ingress-nginx namespace for pods
kubectl get pods -n ingress-nginx -w
```

Wait until the controller pod is `Running` and `1/1` ready:

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

Verify the IngressClass was created:

```bash
kubectl get ingressclass
```

<details>
<summary>Hint: Checking controller status</summary>

```bash
# The controller runs in the ingress-nginx namespace
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx

# An IngressClass named "nginx" should be available
kubectl get ingressclass nginx -o yaml
```
</details>
