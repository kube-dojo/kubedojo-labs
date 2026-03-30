# Configure Rolling Update Parameters

The default strategy is RollingUpdate. You can control the speed and safety of rollouts with `maxSurge` and `maxUnavailable`.

## Task

Create a deployment named `rolling-app` in `strategy-lab` with:
- Image: `nginx:1.24`
- Replicas: 4
- Strategy: RollingUpdate
- `maxSurge: 1`
- `maxUnavailable: 0`

Then update the image to `nginx:1.25` and observe that pods are replaced one at a time (zero downtime).

Save the strategy type to `/root/strategy-type.txt`.

## Hint

Set `maxUnavailable: 0` to ensure no pods are removed before new ones are ready. `maxSurge: 1` means only 1 extra pod is created at a time. Check with `kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.strategy.type}'`.
