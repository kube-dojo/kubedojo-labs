#!/bin/bash
cat > /etc/apparmor.d/usr.bin.curl << 'EOF'
#include <tunables/global>

/usr/bin/curl {
  #include <abstractions/base>
  #include <abstractions/nameservice>

  # Allow reading network config and SSL certs
  /etc/hosts r,
  /etc/resolv.conf r,
  /etc/ssl/** r,

  # Allow reading shared resources
  /usr/share/** r,

  # Deny writes to /etc
  deny /etc/** w,

  # Allow network access for HTTP/HTTPS
  network inet stream,
  network inet6 stream,
  network inet dgram,
  network inet6 dgram,
}
EOF

apparmor_parser -r /etc/apparmor.d/usr.bin.curl 2>/dev/null || true
