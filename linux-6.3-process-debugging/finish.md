# Congratulations!

You have completed the Process Debugging lab.

## What You Learned

- Tracing system calls with `strace`
- Listing open files with `lsof`
- Tracing library calls with `ltrace`

## Key Takeaways

1. **strace** is your first tool when a process behaves unexpectedly
2. **lsof** reveals file descriptors, sockets, and locks held by a process
3. **ltrace** helps debug application-level logic through library calls
4. These tools work on production systems with minimal overhead when used carefully

## Next Steps

- Explore `linux-6.4-network-debugging` for network-specific debugging
- Learn `perf` for performance profiling
- Study eBPF tools for modern, low-overhead tracing
