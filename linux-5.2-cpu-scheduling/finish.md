# Congratulations!

You have completed the CPU Scheduling and Process Priorities lab.

## What You Learned

- Linux scheduling policies (SCHED_OTHER, SCHED_FIFO, SCHED_RR)
- Inspecting scheduling with `chrt`
- Pinning processes to CPUs with `taskset`
- Adjusting CPU priority with `nice`/`renice` and I/O priority with `ionice`

## Key Takeaways

1. **SCHED_OTHER (CFS)** is the default and suitable for most workloads
2. **Real-time policies** (FIFO, RR) should be used carefully — they can starve other processes
3. **CPU affinity** improves cache performance but reduces scheduler flexibility
4. **Nice values** are a simple way to prioritize between competing processes

## Next Steps

- Explore `linux-5.3-memory-management` for memory performance tuning
- Study cgroup-based CPU limiting for containerized workloads
