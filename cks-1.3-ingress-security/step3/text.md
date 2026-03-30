# Enforce HTTPS Redirect and Security Headers

Add security-focused annotations to the Ingress resource.

## Task

1. Update the `secure-ingress` to include these annotations:
   - `nginx.ingress.kubernetes.io/ssl-redirect: "true"`
   - `nginx.ingress.kubernetes.io/force-ssl-redirect: "true"`
   - `nginx.ingress.kubernetes.io/configuration-snippet` with security headers:
     - `X-Frame-Options: DENY`
     - `X-Content-Type-Options: nosniff`
     - `X-XSS-Protection: 1; mode=block`
2. Save the updated Ingress YAML to `/root/secure-ingress-final.yaml`.

## Hint

Use `kubectl annotate` or edit the YAML directly. For the configuration-snippet, use a multi-line string with `more_set_headers` directives.
