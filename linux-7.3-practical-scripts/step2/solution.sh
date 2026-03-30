#!/bin/bash
# Solution: Create health check script
cat > /root/healthcheck.sh << 'SCRIPT'
#!/bin/bash

# CPU Check
LOAD=$(awk '{print $1}' /proc/loadavg)
CPUS=$(nproc)
LOAD_INT=$(echo "$LOAD" | awk '{printf "%d", $1}')
if [ "$LOAD_INT" -gt "$CPUS" ]; then
  echo "[WARN] CPU: Load average $LOAD ($CPUS CPUs)"
else
  echo "[OK] CPU: Load average $LOAD ($CPUS CPUs)"
fi

# Memory Check
MEM_USED=$(free | awk '/^Mem:/ {printf "%d", $3/$2 * 100}')
if [ "$MEM_USED" -gt 90 ]; then
  echo "[WARN] Memory: ${MEM_USED}% used"
else
  echo "[OK] Memory: ${MEM_USED}% used"
fi

# Disk Check
DISK_USED=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$DISK_USED" -gt 80 ]; then
  echo "[WARN] Disk: ${DISK_USED}% used"
else
  echo "[OK] Disk: ${DISK_USED}% used"
fi

# Service Check
if pgrep -x bash > /dev/null 2>&1; then
  echo "[OK] Service: bash is running"
else
  echo "[WARN] Service: bash is not running"
fi
SCRIPT
chmod +x /root/healthcheck.sh
/root/healthcheck.sh
