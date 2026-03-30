# Troubleshoot a Broken Deployment

The setup created `broken-deploy` in `deploy-lab` with a non-existent image. Fix it.

## Task

1. Check `broken-deploy` — pods should be in ImagePullBackOff.
2. Fix the deployment by setting the image to `nginx:1.25`.
3. Wait for all 3 replicas to be ready.
4. Save the number of available replicas to `/root/fixed-replicas.txt`.

## Hint

Use `kubectl set image deployment/broken-deploy nginx=nginx:1.25 -n deploy-lab` to fix the image.
