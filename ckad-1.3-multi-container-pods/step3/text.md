# Build an Adapter Container Pattern

An adapter container transforms the output of the main application into a standardized format.

## Task

Create a pod named `adapter-pod` in `multi-lab` with:

1. A main container named `app` using `busybox:1.36` that writes raw metrics:
   - Command: `sh -c "while true; do echo \"$(date +%s) cpu_usage $(( RANDOM % 100 ))\" >> /metrics/raw.log; sleep 5; done"`
2. An adapter container named `transformer` using `busybox:1.36` that reads raw metrics and outputs in a formatted way:
   - Command: `sh -c "tail -f /metrics/raw.log | while read line; do echo \"METRIC: $line\" >> /metrics/formatted.log; done"`
3. Both containers share an `emptyDir` volume named `metrics` mounted at `/metrics`.

Wait until the pod is running and verify that `/metrics/formatted.log` exists inside the `transformer` container.

## Hint

Both containers write/read from the shared `/metrics` volume. The adapter reads `raw.log` and writes `formatted.log`.
