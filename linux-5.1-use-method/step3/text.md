# Create a USE Checklist

The power of the USE method is having a systematic checklist for every resource. For each resource, document the commands for Utilization, Saturation, and Errors.

## Example Checklist Entry

| Resource | Utilization | Saturation | Errors |
|----------|-------------|------------|--------|
| CPU | `mpstat -P ALL 1 1` | `vmstat 1 1` (r column) | `dmesg \| grep -i "mce"` |

## Your Task

Create `/root/use-checklist.txt` with USE commands for all four resources: **CPU, Memory, Disk, Network**.

Your file should contain entries for each resource with at least one command per metric. Format:

```
CPU:
  Utilization: <command>
  Saturation: <command>
  Errors: <command>

Memory:
  Utilization: <command>
  Saturation: <command>
  Errors: <command>

Disk:
  Utilization: <command>
  Saturation: <command>
  Errors: <command>

Network:
  Utilization: <command>
  Saturation: <command>
  Errors: <command>
```

Fill in actual Linux commands for each metric.
