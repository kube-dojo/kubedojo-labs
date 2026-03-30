# Restrict Secret Access with RBAC

Create RBAC rules that limit which users and ServiceAccounts can read secrets.

## Task

1. Create a Role named `secret-reader` in `secrets-lab` that allows `get` on secrets (but NOT `list` or `watch`).
2. Create a ServiceAccount named `app-sa` in `secrets-lab`.
3. Create a RoleBinding binding `secret-reader` to `app-sa`.
4. Verify that `app-sa` can get a specific secret but cannot list all secrets. Save the verification to `/root/secret-rbac-test.txt`.
5. Create `/root/secrets-best-practices.txt` with at least 5 secrets management best practices.

## Hint

Restricting `list` on secrets prevents enumeration. A ServiceAccount should only be able to `get` the specific secrets it needs.
