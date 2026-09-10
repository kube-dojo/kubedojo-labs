#!/bin/bash
# KubeDojo lab scenario tester (Ubuntu scenarios).
#
# Boots each scenario-lane in a fresh privileged container running REAL
# systemd as PID 1 (built from scripts/ci/Dockerfile.ubuntu-harness), so
# scenarios exercise actual namespace / cgroup v2 / LSM / overlay / service
# behavior instead of a mocked systemctl in an unprivileged container.
#
# Trust boundary: scenario code is untrusted and runs fully privileged, but
# ONLY inside a disposable container on a disposable host (CI: ephemeral
# GitHub-hosted runner; locally: your own docker VM). Never wire this script
# into a workflow that exposes secrets or a writable token to it.
#
# Usage:
#   scripts/test-scenario.sh --all              # every ubuntu scenario
#   scripts/test-scenario.sh linux-2.1-namespaces [more...]
set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IMAGE="kubedojo-labs-harness:local"
LANE_TIMEOUT="${LANE_TIMEOUT:-420}"
PASS=0; FAIL=0
FAILED_SCENARIOS=()

build_image() {
  echo "Building harness image..."
  docker build -q -t "$IMAGE" -f "$REPO_ROOT/scripts/ci/Dockerfile.ubuntu-harness" \
    "$REPO_ROOT/scripts/ci" >/dev/null || {
      echo "FATAL: harness image build failed" >&2; exit 1; }
}

test_scenario_as_user() {
  local scenario_dir="$1" test_user="$2"
  local cname="kd-lab-$$-$RANDOM"
  echo "    TESTING AS $test_user..."
  docker run -d --rm --name "$cname" \
    --privileged --cgroupns=private \
    --tmpfs /run --tmpfs /run/lock --tmpfs /tmp \
    -v "$scenario_dir:/scenario:ro" \
    "$IMAGE" >/dev/null || return 1

  # Wait for systemd to settle; "degraded" (some units failed) is fine —
  # scenarios assert their own service state. Poll instead of
  # `is-system-running --wait`, which can hang before dbus is up.
  local state="" i
  for i in $(seq 1 45); do
    if [ "$(docker inspect -f '{{.State.Running}}' "$cname" 2>/dev/null)" != "true" ]; then
      break  # container died — no point polling out the full window
    fi
    state=$(docker exec "$cname" systemctl is-system-running 2>/dev/null)
    case "$state" in running|degraded) break ;; esac
    sleep 2
  done
  case "$state" in
    running|degraded) ;;
    *)
      echo "      FAIL: systemd did not boot (state: ${state:-none})"
      docker rm -f "$cname" >/dev/null 2>&1
      return 1
      ;;
  esac

  timeout "$LANE_TIMEOUT" docker exec -e TEST_USER="$test_user" "$cname" \
    bash /opt/harness/run-lane.sh
  local rc=$?
  [ $rc -eq 124 ] && echo "      FAIL: lane timed out after ${LANE_TIMEOUT}s"
  docker rm -f "$cname" >/dev/null 2>&1
  return $rc
}

test_scenario() {
  local scenario_dir="$1"; local name; name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"
  [ -f "$index_json" ] || return 0
  local imageid
  imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)
  if [ "$imageid" != "ubuntu" ]; then return 0; fi
  echo "  TEST $name..."
  if test_scenario_as_user "$scenario_dir" "root" && \
     test_scenario_as_user "$scenario_dir" "ubuntu"; then
    echo "  PASS $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL $name"
    FAIL=$((FAIL + 1))
    FAILED_SCENARIOS+=("$name")
  fi
}

echo "KubeDojo Lab Scenario Tester"
build_image
for arg in "$@"; do
  if [ "$arg" == "--all" ]; then
    for scenario in "$REPO_ROOT"/*-*/; do
      [ -d "$scenario" ] && test_scenario "${scenario%/}"
    done
  else
    test_scenario "$REPO_ROOT/$arg"
  fi
done
echo ""
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
  printf 'FAILED: %s\n' "${FAILED_SCENARIOS[@]}"
  exit 1
fi
