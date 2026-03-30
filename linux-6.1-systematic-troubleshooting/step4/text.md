# Document Findings

The final and most important step: document everything. A good troubleshooting report helps future investigations and team communication.

## Report Template

A troubleshooting report should contain at minimum:

1. **Problem** — what was observed
2. **Investigation Steps** — what you checked
3. **Root Cause** — what caused the issue
4. **Fix/Resolution** — what was done (or should be done)

## Your Task

Create `/root/troubleshooting-report.txt` with the following sections based on your investigation:

```
=== Problem ===
<Describe the issue — a service is failing, errors in logs>

=== Investigation Steps ===
<List what you checked: system stats, services, logs>

=== Root Cause ===
<What caused the issue — the broken-app service binary doesn't exist>

=== Fix ===
<How to resolve — install the binary, fix the service config, etc.>
```

Fill in each section with specific details from your investigation.
