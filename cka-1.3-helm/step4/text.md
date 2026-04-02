# Upgrade and Rollback

Helm tracks release revisions, making it easy to upgrade and rollback.

**Key commands:**
```bash
helm upgrade <release> <chart> --set key=value   # Upgrade with new values
helm rollback <release> <revision>                # Rollback to revision
helm history <release>                            # Show revision history
```

## Task

1. Upgrade the `web` release to use 3 replicas: `--set replicaCount=3`
2. Then rollback to revision 1 (the original installation).
3. Verify with `helm history web` — you should see 3 revisions.

<details>
<summary>Hint</summary>

```bash
helm upgrade web bitnami/nginx --set replicaCount=3
helm rollback web 1
helm history web
```
</details>