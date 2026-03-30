# Create and Manage Custom Resources

## Task

1. Create a BackupJob custom resource named `daily-backup` in `crd-lab`:
   ```yaml
   apiVersion: stable.example.com/v1
   kind: BackupJob
   metadata:
     name: daily-backup
     namespace: crd-lab
   spec:
     schedule: "0 2 * * *"
     target: "production-db"
     retention: 7
   ```
2. Create another BackupJob named `weekly-backup` in `crd-lab` with schedule `0 3 * * 0`, target `staging-db`, retention 30.
3. List all BackupJobs: `kubectl get backupjobs -n crd-lab` (or `kubectl get bj -n crd-lab`).
4. Save the list to `/root/backupjobs-list.txt`.

## Hint

Custom resources use the same `kubectl` commands as built-in resources. See the Kubernetes docs: Manage Custom Resources.
