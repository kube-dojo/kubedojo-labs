# Use Projected Service Account Tokens

Projected tokens are short-lived and audience-scoped, replacing long-lived secret-based tokens.

## Task

1. Create a pod named `projected-token-pod` in `sa-lab` that uses a projected volume for the ServiceAccount token with:
   - `expirationSeconds: 3600`
   - `audience: api`
   - Mounted at `/var/run/secrets/tokens`
2. Verify the projected token is mounted and save its path listing to `/root/projected-token.txt`.
3. Create `/root/token-comparison.txt` explaining the difference between legacy and projected tokens (at least 3 differences).

## Hint

Use `spec.volumes[].projected.sources[].serviceAccountToken` with `audience` and `expirationSeconds` fields.
