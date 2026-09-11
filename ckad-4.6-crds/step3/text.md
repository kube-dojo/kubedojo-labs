# Query and Filter Custom Resources

## Task

1. Get the `daily-backup` BackupJob in YAML format and save to `$HOME/daily-backup.yaml`:
   ```
   kubectl get backupjob daily-backup -n crd-lab -o yaml > $HOME/daily-backup.yaml
   ```
2. Extract the target field using jsonpath:
   ```
   kubectl get backupjob daily-backup -n crd-lab -o jsonpath='{.spec.target}'
   ```
   Save to `$HOME/backup-target.txt`.
3. Delete the `weekly-backup` BackupJob.
4. Save the remaining BackupJob count to `$HOME/bj-count.txt`.

## Hint

Custom resources support all jsonpath queries. `kubectl get bj -n crd-lab --no-headers | wc -l` counts custom resources.
