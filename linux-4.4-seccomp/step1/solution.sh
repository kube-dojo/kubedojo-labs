#!/bin/bash
{
  echo "=== seccomp Status Report ==="
  echo ""
  echo "--- PID 1 (init/systemd) ---"
  grep Seccomp /proc/1/status 2>/dev/null || echo "Seccomp field not found for PID 1"

  echo ""
  echo "--- Current Shell ---"
  grep Seccomp /proc/self/status 2>/dev/null || echo "Seccomp field not found for current process"

  echo ""
  echo "--- Explanation ---"
  echo "Seccomp values:"
  echo "  0 = Disabled (no syscall filtering)"
  echo "  1 = Strict mode (only read, write, exit, sigreturn)"
  echo "  2 = Filter mode (BPF-based custom filter, used by containers)"
  echo ""
  echo "In a Kubernetes pod, containers typically run with Seccomp: 2 (filter)"
  echo "when the RuntimeDefault or a custom seccomp profile is applied."
} > /root/seccomp-status.txt
