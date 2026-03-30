# Run kube-bench and Analyze Results

Run CIS benchmark checks against the cluster and categorize the findings.

## Task

1. Run kube-bench as a Job:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml
   ```
2. Wait for completion and save results to `/root/bench-results.txt`.
3. Extract only the `[FAIL]` lines and save to `/root/bench-failures.txt`.
4. Count failures per section (1-Master, 2-Etcd, 3-Control Plane, 4-Worker, 5-Policies) and save to `/root/failure-summary.txt` in format `section: count`.

## Hint

Use `grep '\[FAIL\]' /root/bench-results.txt` and then `grep -c` per section prefix (e.g., `1.`, `2.`, etc.).
