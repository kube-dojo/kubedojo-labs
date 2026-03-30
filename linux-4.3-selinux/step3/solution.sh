#!/bin/bash
{
  echo "=== SELinux Booleans ==="
  echo ""

  # Try listing booleans
  BOOLEANS=$(getsebool -a 2>&1)
  if [ $? -eq 0 ] && ! echo "$BOOLEANS" | grep -qi "error\|disabled"; then
    echo "Active booleans from getsebool -a:"
    echo "$BOOLEANS"
    echo ""
    COUNT=$(echo "$BOOLEANS" | wc -l)
    echo "Total booleans: $COUNT"
  else
    echo "SELinux is not active on this system. getsebool output:"
    echo "$BOOLEANS"
    echo ""
    echo "--- Important SELinux Booleans (reference) ---"
    echo ""
    echo "1. httpd_can_network_connect (off)"
    echo "   Allow Apache/nginx to make outbound network connections"
    echo ""
    echo "2. httpd_enable_homedirs (off)"
    echo "   Allow web server to access user home directories"
    echo ""
    echo "3. container_manage_cgroup (off)"
    echo "   Allow container processes to manage cgroups"
    echo ""
    echo "4. virt_use_nfs (off)"
    echo "   Allow virtual machines to access NFS shares"
    echo ""
    echo "5. httpd_can_connect_ldap (off)"
    echo "   Allow web server to connect to LDAP for authentication"
    echo ""
    echo "6. httpd_use_nfs (off)"
    echo "   Allow web server to serve files from NFS mounts"
    echo ""
    echo "7. allow_ptrace (off)"
    echo "   Allow processes to ptrace other processes (debugging)"
    echo ""
    echo "These booleans are toggled with: setsebool -P <boolean> on|off"
  fi
} > /root/sebooleans.txt
