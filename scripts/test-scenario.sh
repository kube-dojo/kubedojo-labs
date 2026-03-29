#!/bin/bash
# Test a Killercoda scenario locally by running setup + simulating steps + verifying
#
# Usage: ./scripts/test-scenario.sh prereq-0.3-first-commands
#        ./scripts/test-scenario.sh --all        # test all scenarios
#
# Requires: docker
#
# For Ubuntu scenarios: runs in ubuntu:22.04 container
# For K8s scenarios: skipped (needs kind cluster, tested separately)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0
SKIP=0

test_scenario() {
  local scenario_dir="$1"
  local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"

  if [ ! -f "$index_json" ]; then
    echo "  SKIP $name (no index.json)"
    SKIP=$((SKIP + 1))
    return
  fi

  # Check environment type
  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)

  if [ "$imageid" = "kubernetes-kubeadm-1node" ]; then
    echo "  SKIP $name (K8s scenario — needs cluster)"
    SKIP=$((SKIP + 1))
    return
  fi

  echo "  TEST $name ($imageid)"

  # Build test script: setup + simulate expected actions + run verify scripts
  local test_script="#!/bin/bash
set -e
cd /root

# Run setup
if [ -f /scenario/setup.sh ]; then
  bash /scenario/setup.sh 2>/dev/null
fi

# Run solution hints from each step (extract commands from hints)
STEPS=\$(ls -d /scenario/step*/ 2>/dev/null | sort)
STEP_NUM=0
for step_dir in \$STEPS; do
  STEP_NUM=\$((STEP_NUM + 1))

  # Extract commands from hint sections (between <details> tags)
  if [ -f \"\$step_dir/text.md\" ]; then
    # Run commands found in hint code blocks
    sed -n '/<details>/,/<\/details>/p' \"\$step_dir/text.md\" | \
      sed -n '/^\`\`\`bash/,/^\`\`\`/p' | \
      grep -v '^\`\`\`' | \
      while IFS= read -r cmd; do
        [ -z \"\$cmd\" ] && continue
        eval \"\$cmd\" 2>/dev/null || true
      done
  fi

  # Run verify
  if [ -f \"\$step_dir/verify.sh\" ]; then
    if bash \"\$step_dir/verify.sh\" 2>/dev/null; then
      echo \"    PASS step \$STEP_NUM\"
    else
      echo \"    FAIL step \$STEP_NUM\"
      exit 1
    fi
  fi
done

echo \"  ALL STEPS PASSED\"
"

  # Run in Docker container
  local result
  result=$(echo "$test_script" | docker run --rm -i \
    -v "$scenario_dir:/scenario:ro" \
    ubuntu:22.04 bash 2>&1) || {
    echo "$result" | grep -E "PASS|FAIL" | head -10
    echo "  FAIL $name"
    FAIL=$((FAIL + 1))
    return
  }

  echo "$result" | grep -E "PASS|FAIL|STEPS" | head -10
  PASS=$((PASS + 1))
}

echo "========================================="
echo "KubeDojo Lab Scenario Tester"
echo "========================================="
echo ""

if [ "${1:-}" = "--all" ]; then
  for scenario in "$REPO_ROOT"/prereq-*/ "$REPO_ROOT"/cka-*/ "$REPO_ROOT"/linux-*/; do
    [ -d "$scenario" ] || continue
    test_scenario "$scenario"
  done
else
  if [ -z "${1:-}" ]; then
    echo "Usage: $0 <scenario-name> | --all"
    exit 1
  fi
  test_scenario "$REPO_ROOT/$1"
fi

echo ""
echo "========================================="
echo "Results: $PASS passed, $FAIL failed, $SKIP skipped"
echo "========================================="

[ "$FAIL" -eq 0 ] || exit 1
