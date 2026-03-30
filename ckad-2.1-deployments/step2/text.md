# Rolling Updates and Image Changes

## Task

1. Update the `webapp` deployment image from `nginx:1.24` to `nginx:1.25` using `kubectl set image`.
2. Record the change by annotating: `kubectl annotate deployment webapp -n deploy-lab kubernetes.io/change-cause="Update to nginx 1.25"`.
3. Wait for the rollout to complete.
4. Verify the new image is `nginx:1.25`.
5. Save the rollout status output to `/root/rollout-status.txt` using `kubectl rollout status deployment/webapp -n deploy-lab`.

## Hint

`kubectl set image deployment/webapp nginx=nginx:1.25 -n deploy-lab` updates the container named `nginx`.
