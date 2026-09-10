#!/bin/bash
# Setup for the Capabilities & LSMs lab. Idempotent: safe to run repeatedly (doubles as reset).

# Tools: capsh/getcap/setcap (libcap2-bin), gcc for the file-capability demo,
# aa-status (apparmor-utils) where the distribution provides it.
apt-get update -qq > /dev/null 2>&1 || true
apt-get install -y -qq libcap2-bin gcc > /dev/null 2>&1 || true
apt-get install -y -qq apparmor-utils > /dev/null 2>&1 || true

# Clean evidence and demo artifacts from a previous run.
rm -rf /tmp/kd-caps /opt/kd-caps
mkdir -p /tmp/kd-caps
chmod 1777 /tmp/kd-caps

# Demo directory on the root filesystem: file capabilities are stored as the
# security.capability xattr and are IGNORED on nosuid mounts (/tmp often is one),
# so the binary must live outside /tmp.
mkdir -p /opt/kd-caps
chmod 755 /opt/kd-caps

# Seed the module's low-port bind program (port 88 to avoid colliding with a web server).
cat > /opt/kd-caps/test-bind.c <<'EOF'
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main() {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in addr = {
        .sin_family = AF_INET,
        .sin_port = htons(88),
        .sin_addr.s_addr = INADDR_ANY
    };
    if (bind(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("bind failed");
        return 1;
    }
    printf("bound port 88 OK\n");
    return 0;
}
EOF

# Seed the ownership-demo target for the capability-drop step.
touch /tmp/kd-caps/testfile
chown root /tmp/kd-caps/testfile 2>/dev/null || true

echo "Setup complete."

# Seed /home/ubuntu if it exists (universal-user support).
if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
