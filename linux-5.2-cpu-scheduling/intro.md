# CPU Scheduling and Process Priorities

The Linux kernel scheduler determines which processes get CPU time and for how long. Understanding scheduling policies and priorities is essential for tuning performance-critical workloads.

## What You Will Learn

- Linux scheduling policies: SCHED_OTHER (default), SCHED_FIFO, SCHED_RR
- How to inspect and change scheduling policies with `chrt`
- CPU affinity — pinning processes to specific cores with `taskset`
- Process priorities with `nice` and I/O priorities with `ionice`

## Prerequisites

- Basic understanding of processes and PIDs
- Familiarity with the command line
