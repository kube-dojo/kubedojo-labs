# Analyze Audit Logs for Security Events

Parse and analyze audit logs to identify suspicious activity.

## Task

1. If audit logs exist at `/var/log/kubernetes/audit/audit.log`, analyze them. Otherwise, create sample audit events by performing various kubectl operations and work with whatever logs are available.
2. Create a script `/root/audit-analyzer.sh` that parses audit logs (JSON format, one per line) and reports:
   - Total number of events
   - Events by verb (create, delete, get, list, etc.)
   - Events involving secrets
   - Events from non-system users
3. Run the script and save output to `/root/audit-analysis.txt`.
4. Create `/root/suspicious-patterns.txt` listing audit patterns that indicate security incidents.

## Hint

Audit log entries are JSON objects with fields like `verb`, `user.username`, `objectRef.resource`, `responseStatus.code`. Use `jq` or Python to parse.
