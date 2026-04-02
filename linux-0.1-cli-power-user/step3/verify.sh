#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify $USER_HOME/unique-ips.txt has multiple unique IPs
if [ ! -f $USER_HOME/unique-ips.txt ]; then
  echo "$USER_HOME/unique-ips.txt does not exist"
  exit 1
fi

line_count=$(wc -l < $USER_HOME/unique-ips.txt | tr -d '[:space:]')
if [ "$line_count" -lt 2 ]; then
  echo "File should have at least 2 unique IPs, got $line_count lines"
  exit 1
fi

# Check that lines look like IP addresses
bad_lines=$(grep -cvE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' $USER_HOME/unique-ips.txt 2>/dev/null || true)
if [ "$bad_lines" -gt 0 ]; then
  echo "Some lines don't look like IP addresses"
  exit 1
fi

echo "Found $line_count unique IPs. Nice work!"
exit 0
