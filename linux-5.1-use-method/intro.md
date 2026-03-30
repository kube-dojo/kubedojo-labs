# USE Method for Performance Analysis

The **USE Method**, created by Brendan Gregg, is a systematic approach to performance analysis. For every resource (CPU, memory, disk, network), you check three metrics:

- **Utilization** — how busy the resource is (percentage over time)
- **Saturation** — the degree of queued work (waiting)
- **Errors** — the count of error events

This lab teaches you to apply the USE method using standard Linux tools to quickly identify performance bottlenecks.

## What You Will Learn

- How to gather utilization, saturation, and error metrics
- Using `uptime`, `vmstat`, `mpstat`, and `pidstat`
- Building a systematic USE checklist for any Linux system

## Prerequisites

- Basic familiarity with the Linux command line
- Understanding of CPU, memory, disk, and network concepts
