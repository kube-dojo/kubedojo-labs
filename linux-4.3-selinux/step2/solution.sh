#!/bin/bash
mkdir -p /root/selinux-lab
touch /root/selinux-lab/testfile.txt

{
  echo "=== File Context Report ==="
  echo ""
  echo "--- Original context ---"
  ls -Z /root/selinux-lab/testfile.txt 2>&1 || echo "ls -Z not supported (SELinux not active)"

  echo ""
  echo "--- Attempting chcon ---"
  echo "Command: chcon -t httpd_sys_content_t /root/selinux-lab/testfile.txt"
  chcon -t httpd_sys_content_t /root/selinux-lab/testfile.txt 2>&1 && echo "SUCCESS: Context changed" || echo "FAILED: SELinux is likely disabled on this kernel"

  echo ""
  echo "--- Context after change attempt ---"
  ls -Z /root/selinux-lab/testfile.txt 2>&1 || echo "Context not available"

  echo ""
  echo "--- Explanation ---"
  echo "On Ubuntu without SELinux kernel support, chcon fails because"
  echo "extended attributes for security contexts are not available."
  echo "On RHEL/CentOS, this would succeed and change the type label."
  echo "The restorecon command would then reset it to the policy default."
} > /root/selinux-lab/context-report.txt
