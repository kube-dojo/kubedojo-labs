#!/bin/bash
# Solution: Create check-disk.sh
cat > /root/check-disk.sh << 'SCRIPT'
#!/bin/bash
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [[ $USAGE -gt 80 ]]; then
  echo "WARNING: Disk usage is above 80% (currently ${USAGE}%)"
else
  echo "OK: Disk usage is normal (currently ${USAGE}%)"
fi
SCRIPT
chmod +x /root/check-disk.sh
/root/check-disk.sh
