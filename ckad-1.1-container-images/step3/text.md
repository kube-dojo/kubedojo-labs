# Troubleshoot ImagePullBackOff Errors

The setup script created a pod `broken-app` in `images-lab` that is failing to start. Your job is to diagnose and fix it.

## Task

1. Check the status of `broken-app` in `images-lab` — it should be in ImagePullBackOff or ErrImagePull.
2. Use `kubectl describe pod broken-app -n images-lab` to find the error.
3. Fix the pod by updating its image to `nginx:1.25`. Since you cannot edit a pod's image directly, delete it and recreate it with the correct image and the same name.
4. Ensure `broken-app` reaches Running state.

## Hint

Delete with `kubectl delete pod broken-app -n images-lab` then recreate with `kubectl run broken-app --image=nginx:1.25 -n images-lab`.
