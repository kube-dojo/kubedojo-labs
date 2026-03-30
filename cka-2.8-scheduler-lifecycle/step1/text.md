## Pod Lifecycle Phases

A pod transitions through several phases: Pending, Running, Succeeded, Failed.

### Task

1. Create a pod that exits successfully and observe its status change to Completed/Succeeded:

   ```bash
   kubectl run lifecycle-pod --image=busybox:1.36 -n practice \
     --restart=Never -- sh -c 'echo "Task complete"; exit 0'
   ```

2. Wait a few seconds, then check the status:

   ```bash
   kubectl get pod lifecycle-pod -n practice
   kubectl get pod lifecycle-pod -n practice -o jsonpath='{.status.phase}'
   ```

   The phase should be `Succeeded`.

3. Check the logs to see the output:
   ```bash
   kubectl logs lifecycle-pod -n practice
   ```

<details>
<summary>Hint: Pod phases explained</summary>

- **Pending**: Pod accepted but not yet scheduled or images being pulled
- **Running**: At least one container is running
- **Succeeded**: All containers terminated with exit code 0
- **Failed**: At least one container terminated with non-zero exit code
- **Unknown**: Pod state cannot be determined

Refer to: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase
</details>
