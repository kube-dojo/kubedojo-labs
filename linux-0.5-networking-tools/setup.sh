#!/bin/bash
# Mock DNS tools for reliable Docker testing
cat <<'MOCK' > /usr/local/bin/dig
#!/bin/bash
if [[ "$*" == *"google.com"* ]]; then echo "8.8.8.8"; else /usr/bin/dig "$@"; fi
MOCK
chmod +x /usr/local/bin/dig

cat <<'MOCK' > /usr/local/bin/host
#!/bin/bash
if [[ "$*" == *"google.com"* ]]; then echo "google.com has address 8.8.8.8"; else /usr/bin/host "$@"; fi
MOCK
chmod +x /usr/local/bin/host

# Start dummy listeners for the tests
apt-get update -qq >/dev/null && apt-get install -y -qq netcat-openbsd >/dev/null 2>&1
(nc -lk 80 &) >/dev/null 2>&1
(nc -lk 22 &) >/dev/null 2>&1
