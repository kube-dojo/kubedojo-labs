## Parallel Jobs

Jobs can run multiple pods in parallel to process a batch of work. The `completions` field sets how many pods must succeed, and `parallelism` controls how many run at once.

### Task

Create a Job named `parallel-job` in the `practice` namespace with:

- Image: `busybox:1.36`
- Command: `sh -c 'echo "Processing item"; sleep 5; echo "Done"'`
- Completions: `5`
- Parallelism: `2`
- Restart policy: `Never`

Watch the Job progress:

```bash
kubectl get job parallel-job -n practice -w
```

<details>
<summary>Hint: Parallel Job spec</summary>

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: parallel-job
  namespace: practice
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: worker
        image: busybox:1.36
        command: ["sh", "-c", "echo Processing item; sleep 5; echo Done"]
      restartPolicy: Never
```
</details>
