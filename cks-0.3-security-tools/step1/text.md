# Run kube-bench CIS Benchmark Checks

kube-bench checks your cluster against CIS Kubernetes Benchmarks. Run it as a Job in the cluster.

## Task

1. Run kube-bench as a Kubernetes Job:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml
   ```
2. Wait for the job to complete and save the logs to `"$HOME"/kube-bench-results.txt`.
3. Count the number of `[FAIL]` results and save the count to `"$HOME"/kube-bench-fails.txt`.
4. Count the number of `[PASS]` results and save the count to `"$HOME"/kube-bench-passes.txt`.

## Hint

Use `kubectl wait --for=condition=Complete job/kube-bench` then `kubectl logs job/kube-bench`.
