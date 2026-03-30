# Use Events for Monitoring

## Task

1. View all events in the `monitoring-lab` namespace:
   ```
   kubectl get events -n monitoring-lab --sort-by='.lastTimestamp'
   ```
2. Save the events to `/root/events.txt`.
3. Filter events to show only Warning-type events across all namespaces:
   ```
   kubectl get events -A --field-selector type=Warning
   ```
   Save to `/root/warning-events.txt`.

## Hint

Events show recent cluster activity — pod scheduling, image pulls, probe failures. `--field-selector type=Warning` filters for warnings.
