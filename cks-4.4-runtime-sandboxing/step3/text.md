# Compare Isolation Levels and Document Tradeoffs

Understand the security vs. performance tradeoffs of different runtime options.

## Task

1. Create a pod named `standard-pod` in `sandbox-lab` using the default runtime (no runtimeClassName). Examine its kernel access by reading `/proc/version` inside the container. Save to `/root/standard-kernel.txt`.
2. Create `/root/isolation-matrix.txt` documenting:
   | Feature | runc | gVisor | Kata |
   |---------|------|--------|------|
   - Kernel shared?
   - Syscall filtering?
   - Performance overhead
   - Memory overhead
   - Use case
3. Create `/root/sandbox-decision.txt` with recommendations for:
   - Multi-tenant SaaS platform
   - Internal trusted microservices
   - Running untrusted user code

## Hint

The key difference is kernel isolation: runc shares the host kernel, gVisor intercepts syscalls in user space, Kata provides a full VM boundary.
