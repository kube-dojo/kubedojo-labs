# Install an Ingress Controller and Create Basic Ingress

The setup script installed the NGINX Ingress Controller. Now create a basic Ingress resource.

## Task

1. Verify the Ingress controller is running:
   ```
   kubectl get pods -n ingress-nginx
   ```
2. Create an Ingress named `basic-ingress` in `ingress-lab` that routes all traffic to the `frontend` service on port 80:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: basic-ingress
     namespace: ingress-lab
   spec:
     ingressClassName: nginx
     rules:
     - http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: frontend
               port:
                 number: 80
   ```
3. Save the Ingress class name to `/root/ingress-class.txt`.

## Hint

`ingressClassName: nginx` tells Kubernetes which Ingress controller handles this resource. See the Kubernetes docs: Ingress.
