# Benchmarking with dd

`dd` is a simple tool for measuring sequential I/O throughput. While not a comprehensive benchmark, it gives a quick baseline.

## Write Throughput

```bash
dd if=/dev/zero of=/tmp/benchmark bs=1M count=100 conv=fdatasync 2>&1
```

- `conv=fdatasync` — forces a physical write (bypasses page cache)
- The output shows throughput in MB/s or GB/s

## Read Throughput

```bash
# Clear page cache first (requires root)
echo 3 > /proc/sys/vm/drop_caches
dd if=/tmp/benchmark of=/dev/null bs=1M 2>&1
```

## Your Task

1. Run a write benchmark: write 100MB with `dd`
2. Capture the throughput line and save to `~/io-benchmark.txt`

**Hint:**
```bash
dd if=/dev/zero of=/tmp/benchmark bs=1M count=100 conv=fdatasync 2>&1 | tail -1 > ~/io-benchmark.txt
```
