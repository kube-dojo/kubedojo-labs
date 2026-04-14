#!/bin/bash
set -euo pipefail

fail() {
  echo "FAIL: $1"
  exit 1
}

member_output=$(ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  --write-out=json \
  member list 2>/dev/null || true)

[ -n "${member_output}" ] || fail "etcdctl member list returned no members"

health_output=$(ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
  --write-out=json \
  endpoint health 2>/dev/null || true)

python3 - "${member_output}" "${health_output}" <<'PY' || exit 1
import json
import sys

members = json.loads(sys.argv[1])
health = json.loads(sys.argv[2])

if len(members.get("members", [])) < 1:
    raise SystemExit("FAIL: Expected at least one etcd member in structured member list output")

if not health:
    raise SystemExit("FAIL: etcdctl endpoint health returned no structured output")

if any(not item.get("health") for item in health):
    raise SystemExit("FAIL: etcdctl endpoint health reported an unhealthy member")

print("PASS: etcd member listing and endpoint health are available from etcdctl.")
PY
