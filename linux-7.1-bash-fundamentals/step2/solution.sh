#!/bin/bash
# Solution: Create users script
cat > /root/create-users.sh << 'SCRIPT'
#!/bin/bash
for i in $(seq 1 5); do
  useradd -m "testuser${i}" 2>/dev/null && echo "Created testuser${i}" || echo "testuser${i} already exists"
done
SCRIPT
chmod +x /root/create-users.sh
/root/create-users.sh
