# Identify Resource-Hungry Pods

## Task

1. List pods sorted by CPU usage (highest first):
   ```
   kubectl top pods -n monitoring-lab --sort-by=cpu
   ```
2. The `stress-pod` should be consuming the most CPU. Save its name to `/root/high-cpu-pod.txt`.
3. Delete the `stress-pod` to reclaim resources.
4. Verify it is deleted and save the remaining pod count to `/root/remaining-pods.txt`.

## Hint

`kubectl top pods --sort-by=cpu` sorts by CPU usage. The stress pod runs an infinite loop consuming CPU.
