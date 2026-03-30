# Configure Authorization Modes

Review and document the API server's authorization configuration.

## Task

1. Extract the `--authorization-mode` flag value from the API server manifest and save to `/root/auth-mode.txt`.
2. Verify that the authorization mode includes both `RBAC` and `Node`. Save "compliant" or "non-compliant" to `/root/auth-mode-check.txt`.
3. List all API resources the current user can access with `kubectl auth can-i --list` and save to `/root/current-user-perms.txt`.
4. Create `/root/auth-mode-explanation.txt` explaining when each authorization mode is used (Node, RBAC, Webhook, AlwaysAllow, AlwaysDeny).

## Hint

`Node` authorization is required for kubelet API access. `RBAC` handles all other authorization. `AlwaysAllow` should NEVER be used in production.
