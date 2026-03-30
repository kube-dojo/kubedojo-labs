# Mount PVCs in Pods

Now use the PVC you created to persist data in a pod.

## Task

1. Create a pod named `pvc-pod` in `volumes-lab` with:
   - Container: `app` using `busybox:1.36`, command: `sh -c "echo persistent-data > /data/output.txt; sleep 3600"`
   - Mount the `pvc-data` PVC at `/data`

2. After the pod is running, verify the data was written by executing:
   ```
   kubectl exec pvc-pod -n volumes-lab -- cat /data/output.txt
   ```

3. Save the output to `/root/persistent-output.txt`.

## Hint

Use `persistentVolumeClaim` as the volume type with `claimName: pvc-data`.
