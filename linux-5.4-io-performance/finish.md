# Congratulations!

You have completed the I/O Performance Analysis lab.

## What You Learned

- Measuring disk I/O with `iostat`
- Linux I/O schedulers and when to use each
- Simple throughput benchmarking with `dd`

## Key Takeaways

1. **iostat %util > 60%** indicates a busy device
2. **NVMe SSDs** often work best with `none` or `mq-deadline` schedulers
3. **dd benchmarks** are rough — use `fio` for production benchmarking
4. **conv=fdatasync** is essential for write benchmarks to bypass cache

## Next Steps

- Explore `fio` for comprehensive I/O benchmarking
- Study the `blktrace` tool for detailed I/O tracing
- Learn about cgroup I/O limits for container workloads
