#!/bin/bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0; SKIP=0

test_scenario() {
  local scenario_dir="$1"; local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"
  [ -f "$index_json" ] || return
  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)
  [ "$imageid" = "ubuntu" ] || return
  echo "  TEST $name ($imageid)"
  docker run --rm -i -v "$scenario_dir:/scenario:ro" -e IMAGE_ID="$imageid" ubuntu:22.04 bash <<'INNER_EOF'
    set -e
    apt-get update -qq >/dev/null && apt-get install -y -qq sudo jq >/dev/null
    if ! id "ubuntu" &>/dev/null; then
      useradd -m -s /bin/bash ubuntu
      echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    fi
    if [ -f /scenario/setup.sh ]; then bash /scenario/setup.sh >/dev/null 2>&1; fi
    USER_HOME=$(eval echo "~ubuntu")
    STEPS=$(ls -d /scenario/step*/ 2>/dev/null | sort)
    STEP_NUM=0
    for step_dir in $STEPS; do
      STEP_NUM=$((STEP_NUM + 1))
      HINT_SCRIPT=/tmp/hint_step${STEP_NUM}.sh
      echo '#!/bin/bash' > "$HINT_SCRIPT"
      echo "cd $USER_HOME" >> "$HINT_SCRIPT"
      if [ -f "$step_dir/text.md" ]; then
        sed -n '/<details>/,/<\/details>/p' "$step_dir/text.md" | sed -n '/^```bash/,/^```/p' | grep -v '^```' >> "$HINT_SCRIPT" || true
      fi
      if grep -cvE '^$|^#!/bin/bash|^cd ' "$HINT_SCRIPT" &>/dev/null; then
        su - ubuntu -c "bash $HINT_SCRIPT" > /tmp/hint_out.log 2>&1 || {
          echo "    ERROR in hint execution (Step $STEP_NUM):"
          cat /tmp/hint_out.log
        }
      fi
      if [ -f "$step_dir/verify.sh" ]; then
        if USER="ubuntu" bash "$step_dir/verify.sh" > /tmp/verify_out.log 2>&1; then
          echo "    PASS step $STEP_NUM"
        else
          echo "    FAIL step $STEP_NUM"
          echo "    REASON:"
          cat /tmp/verify_out.log
          exit 1
        fi
      fi
    done
    echo "  ALL STEPS PASSED"
INNER_EOF
  [ $? -eq 0 ] && PASS=$((PASS + 1)) || FAIL=$((FAIL + 1))
}
test_scenario "$REPO_ROOT/$1"
