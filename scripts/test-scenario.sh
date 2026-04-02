#!/bin/bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0; SKIP=0

test_scenario_as_user() {
  local scenario_dir="$1"
  local name=$(basename "$scenario_dir")
  local test_user="$2"
  local imageid="$3"
  
  echo "    TESTING AS $test_user..."
  
  docker run --rm -i -v "$scenario_dir:/scenario:ro" -e IMAGE_ID="$imageid" -e TEST_USER="$test_user" ubuntu:22.04 bash <<'INNER_EOF'
    set -e
    # Prepare environment
    if [ "$TEST_USER" == "ubuntu" ]; then
      useradd -m -s /bin/bash ubuntu
      echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers || true
    fi
    
    # Run setup AS ROOT
    if [ -f /scenario/setup.sh ]; then 
      bash /scenario/setup.sh > /dev/null 2>&1
    fi
    
    USER_HOME=$(eval echo "~$TEST_USER")
    
    # Run steps
    STEPS=$(ls -d /scenario/step*/ 2>/dev/null | sort)
    STEP_NUM=0
    for step_dir in $STEPS; do
      STEP_NUM=$((STEP_NUM + 1))
      HINT_SCRIPT=/tmp/hint_step${STEP_NUM}.sh
      echo '#!/bin/bash' > "$HINT_SCRIPT"
      echo "cd $USER_HOME" >> "$HINT_SCRIPT"
      
      if [ -f "$step_dir/text.md" ]; then
        sed -n '/<details>/,/<\/details>/p' "$step_dir/text.md" | \
          sed -n '/^```bash/,/^```/p' | \
          grep -v '^```' >> "$HINT_SCRIPT" || true
      fi

      HINT_LINES=$(grep -cvE '^$|^#!/bin/bash|^cd ' "$HINT_SCRIPT" || true)

      if [ "$HINT_LINES" -gt 0 ]; then
        su - "$TEST_USER" -c "bash $HINT_SCRIPT" > /dev/null 2>&1
      elif [ -f "$step_dir/solution.sh" ]; then
        su - "$TEST_USER" -c "bash $step_dir/solution.sh" > /dev/null 2>&1
      fi

      # Run verify AS ROOT
      if [ -f "$step_dir/verify.sh" ]; then
        if ! (HOME="$USER_HOME" USER="$TEST_USER" bash "$step_dir/verify.sh" > /dev/null 2>&1); then
          echo "      FAIL step $STEP_NUM"
          exit 1
        fi
      fi
    done
    exit 0
INNER_EOF
}

test_scenario() {
  local scenario_dir="$1"; local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"
  [ -f "$index_json" ] || return
  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)
  [ "$imageid" = "ubuntu" ] || return
  
  echo "  TEST $name ($imageid)"
  
  # A robust lab must pass as BOTH root and ubuntu to be considered "Dojo Quality"
  if test_scenario_as_user "$scenario_dir" "root" "$imageid" && \
     test_scenario_as_user "$scenario_dir" "ubuntu" "$imageid"; then
    echo "    PASS (Universal)"
    PASS=$((PASS + 1))
  else
    echo "    FAIL (Environment dependent)"
    FAIL=$((FAIL + 1))
  fi
}

if [ "${1:-}" = "--all" ]; then
  for scenario in "$REPO_ROOT"/prereq-*/; do [ -d "$scenario" ] && test_scenario "$scenario"; done
else
  test_scenario "$REPO_ROOT/$1"
fi

echo ""
echo "========================================="
echo "Results: $PASS passed, $FAIL failed"
echo "========================================="
[ "$FAIL" -eq 0 ] || exit 1
