# Log Aggregation and Correlation

In real systems, you need to correlate events across multiple logs. The application log (`~/app.log`) shows the backend perspective of the same timeframe as the access log.

## Filtering by Time

```bash
# Extract entries between timestamps
awk '$1 >= "2026-03-29T10:00:05" && $1 <= "2026-03-29T10:00:15"' ~/app.log
```

## Correlating Logs

Match the 5xx errors in the access log with ERROR entries in the application log to understand the full picture.

## Your Task

1. Extract all log entries from `~/app.log` that occurred at `10:00:05` or later
2. Save them to `~/recent-logs.txt`

**Hint:**
```bash
awk '$1 >= "2026-03-29T10:00:05"' ~/app.log > ~/recent-logs.txt
```
