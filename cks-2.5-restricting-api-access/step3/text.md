# Implement API Request Rate Limiting

Protect the API server from abuse with request throttling.

## Task

1. Check the current API server rate limiting flags (`--max-requests-inflight`, `--max-mutating-requests-inflight`). Save to `/root/rate-limits.txt`.
2. Document the default values and what they control in `/root/rate-limit-docs.txt`.
3. Check EventRateLimit admission controller status and create `/root/event-rate-limit.txt` explaining:
   - What EventRateLimit does
   - How to configure it
   - Why it is important for security
4. Create `/root/api-hardening-summary.txt` with a comprehensive API hardening checklist (at least 6 items).

## Hint

`--max-requests-inflight` defaults to 400 (read) and `--max-mutating-requests-inflight` defaults to 200 (write). EventRateLimit is an admission controller.
