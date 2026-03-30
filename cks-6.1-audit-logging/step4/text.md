# Create Audit Alerting Rules

Define rules for detecting security incidents from audit logs.

## Task

1. Create `/root/alert-rules.txt` with at least 5 audit-based alert rules in format:
   ```
   RULE: <name>
   CONDITION: <what to look for in audit logs>
   SEVERITY: <critical/warning/info>
   ACTION: <what to do when triggered>
   ```
2. Create a script `/root/check-secrets-access.sh` that:
   - Reads the audit log
   - Finds all unique users who accessed secrets
   - Reports the count per user
3. Run it and save output to `/root/secrets-access-report.txt`.

## Hint

Focus on high-value targets: secrets, RBAC, node access, exec/attach operations. Use `grep` or `jq` to filter JSON audit entries.
