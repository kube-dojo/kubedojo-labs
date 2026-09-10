#!/bin/bash
# Solution: Create team script
cat > "$HOME"/create-team.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

# Create group
sudo groupadd -f ops-team

# Create users
for user in ops-alice ops-bob ops-charlie; do
  sudo useradd -m -g ops-team -s /bin/bash "$user" 2>/dev/null && \
    echo "Created $user" || echo "$user already exists"
done

echo "Team members:"
grep ops-team /etc/group
SCRIPT
chmod +x "$HOME"/create-team.sh
"$HOME"/create-team.sh
