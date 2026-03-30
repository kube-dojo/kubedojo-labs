# Deploy an Ingress with TLS Termination

Create an Ingress resource that terminates TLS using the secret you created.

## Task

1. Create an Ingress resource named `secure-ingress` in the `ingress-lab` namespace:
   - Host: `secure.example.com`
   - TLS using `tls-secret`
   - Route to `web-app` service on port 80
   - IngressClassName: `nginx` (or omit if no controller is installed)
2. Save the Ingress YAML to `/root/secure-ingress.yaml`.

## Hint

Use `kubectl create ingress` or write YAML with `spec.tls` section referencing the secret and host.
