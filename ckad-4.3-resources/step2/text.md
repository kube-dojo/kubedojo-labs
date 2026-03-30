# Create LimitRanges

LimitRanges set default, min, and max resource constraints for a namespace.

## Task

1. Create a LimitRange named `default-limits` in `resources-lab`:
   ```yaml
   default CPU limit: 500m
   default CPU request: 100m
   default memory limit: 256Mi
   default memory request: 64Mi
   ```
2. Create a pod named `auto-limits` in `resources-lab` with image `nginx:1.25` WITHOUT specifying any resources.
3. Verify the pod got default resources from the LimitRange.
4. Save the auto-assigned CPU limit to `/root/auto-cpu-limit.txt`.

## Hint

LimitRanges use `type: Container` with `default` (limits) and `defaultRequest` (requests) fields.
