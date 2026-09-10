#!/bin/bash
# Solution: Create users script
cat > "$HOME"/create-users.sh << 'SCRIPT'
#!/bin/bash
for i in $(seq 1 5); do
  sudo useradd -m "testuser${i}" 2>/dev/null && echo "Created testuser${i}" || echo "testuser${i} already exists"
done
SCRIPT
chmod +x "$HOME"/create-users.sh
"$HOME"/create-users.sh
