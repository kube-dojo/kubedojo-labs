## TLS Termination

Ingress can terminate TLS using a Kubernetes Secret containing a certificate and private key.

### Task

1. Generate a self-signed TLS certificate for `secure.example.com`
2. Create a TLS Secret named `tls-secret` in the `practice` namespace
3. Create an Ingress named `tls-ingress` that uses this secret for `secure.example.com` routing to `app-v1` on port **80**

```bash
# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /root/tls.key -out /root/tls.crt \
  -subj "/CN=secure.example.com/O=kubedojo"

# Create TLS secret
kubectl create secret tls tls-secret \
  --cert=/root/tls.crt \
  --key=/root/tls.key \
  -n practice
```

Then create the TLS Ingress and test it:

```bash
INGRESS_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
curl -sk -H "Host: secure.example.com" https://localhost:$INGRESS_PORT
```

<details>
<summary>Hint: TLS Ingress YAML</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
  namespace: practice
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - secure.example.com
    secretName: tls-secret
  rules:
  - host: secure.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app-v1
            port:
              number: 80
```
</details>
