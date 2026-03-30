# Use Parallelism and Completions

Jobs can run multiple pods in parallel and require a specific number of successful completions.

## Task

1. Create a Job named `parallel-job` in `jobs-lab` with:
   - Image: `busybox:1.36`
   - Command: `sh -c "echo Processing item; sleep 5; echo Done"`
   - `completions: 4`
   - `parallelism: 2`
2. Wait for all 4 completions.
3. Save the total number of succeeded pods to `/root/parallel-count.txt`.

## Hint

You need to write YAML for this — there is no imperative flag for completions/parallelism. Generate a base with `kubectl create job parallel-job --image=busybox:1.36 --dry-run=client -o yaml`, then add `completions` and `parallelism` under `spec`.
