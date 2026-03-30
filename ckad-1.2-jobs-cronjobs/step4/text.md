# Troubleshoot a Failing Job

The setup created a Job `broken-job` in `jobs-lab` that keeps failing. Diagnose and fix it.

## Task

1. Check the status of `broken-job` — it should have failed pods.
2. Look at the pod logs to understand why it is failing (the command runs `exit 1`).
3. Delete the broken Job.
4. Create a new Job named `fixed-job` in `jobs-lab` with image `busybox:1.36` that runs `sh -c "echo Success; exit 0"` with `backoffLimit: 2`.
5. Wait for `fixed-job` to complete.

## Hint

Check the command: the original runs `exit 1` (failure). Your fixed version should `exit 0` (success).
