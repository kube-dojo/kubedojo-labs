# Configure Anonymous and Token-Based Access Controls

Understand how anonymous access works and verify token authentication.

## Task

1. Test anonymous API access: `curl -sk https://localhost:6443/api/v1/namespaces` and save the response status to `/root/anon-access.txt`.
2. Test authenticated access using the admin kubeconfig and save to `/root/auth-access.txt`.
3. Create a ServiceAccount named `limited-user` in `default` namespace, create a token for it, and test API access with that token. Save the response to `/root/sa-access.txt`.
4. Document the difference in access between anonymous, ServiceAccount token, and admin kubeconfig in `/root/access-comparison.txt`.

## Hint

Use `kubectl create token limited-user` to generate a short-lived token. Use `curl -H "Authorization: Bearer <token>"` to test.
