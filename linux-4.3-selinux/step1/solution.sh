#!/bin/bash
{
  echo "=== SELinux Status (sestatus) ==="
  sestatus 2>&1

  echo ""
  echo "=== Current Mode (getenforce) ==="
  getenforce 2>&1

  echo ""
  echo "=== Available SELinux Modes ==="
  echo "1. Enforcing  — policies enforced, violations blocked and logged"
  echo "2. Permissive — policies not enforced, violations logged only"
  echo "3. Disabled   — SELinux completely turned off"

  echo ""
  echo "Note: On this Ubuntu system, SELinux kernel support may not be"
  echo "enabled. On RHEL/CentOS/Fedora systems, SELinux is enforcing by default."
} > /root/selinux-status.txt
