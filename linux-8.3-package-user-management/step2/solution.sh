#!/bin/bash
# Solution: Create team script
cat > /root/create-team.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

# Create group
groupadd -f ops-team

# Create users
for user in ops-alice ops-bob ops-charlie; do
  useradd -m -g ops-team -s /bin/bash "$user" 2>/dev/null && \
    echo "Created $user" || echo "$user already exists"
done

echo "Team members:"
grep ops-team /etc/group
SCRIPT
chmod +x /root/create-team.sh
/root/create-team.sh
