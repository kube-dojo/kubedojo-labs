#!/bin/bash
# Verify: host and lab-net network-namespace identities recorded and distinct,
# and the inside identity is really lab-net's (inode match against its handle).
HOSTF=/tmp/kd-ns/net-host.txt
INSIDEF=/tmp/kd-ns/net-inside.txt
if [ ! -s "$HOSTF" ] || [ ! -s "$INSIDEF" ]; then
  echo "FAIL: evidence files missing — record net-host.txt and net-inside.txt"
  exit 1
fi
hostid=$(head -n1 "$HOSTF" | tr -d '[:space:]')
insideid=$(head -n1 "$INSIDEF" | tr -d '[:space:]')
for v in "$hostid" "$insideid"; do
  if ! printf '%s' "$v" | grep -Eq '^net:\[[0-9]+\]$'; then
    echo "FAIL: expected a net:[...] identity, got: $v"
    exit 1
  fi
done
if [ "$hostid" = "$insideid" ]; then
  echo "FAIL: both identities are the same namespace — the second command did not enter lab-net"
  exit 1
fi
if [ ! -e /run/netns/lab-net ]; then
  echo "FAIL: /run/netns/lab-net is gone — recreate it (step 3) and retry"
  exit 1
fi
expected_inode=$(stat -Lc %i /run/netns/lab-net)
inside_inode=$(printf '%s' "$insideid" | grep -Eo '[0-9]+')
if [ "$inside_inode" != "$expected_inode" ]; then
  echo "FAIL: net-inside.txt ($insideid) is not lab-net's namespace (expected inode $expected_inode)"
  exit 1
fi
echo "PASS: entered lab-net and proved a distinct network identity"
exit 0
