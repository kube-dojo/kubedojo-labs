#!/bin/bash
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0; SKIP=0

test_scenario_as_user() {
  local scenario_dir="$1"; local test_user="$2"; local imageid="$3"
  echo "    TESTING AS $test_user..."
  docker run --rm -i -v "$scenario_dir:/scenario:ro" -e IMAGE_ID="$imageid" -e TEST_USER="$test_user" ubuntu:22.04 bash <<'INNER_EOF'
    set -e
    apt-get update -qq >/dev/null && apt-get install -y -qq python3 jq sudo tmux curl >/dev/null 2>&1
    echo -e '#!/bin/bash\necho "MOCKED: systemctl $*"\nexit 0' > /usr/local/bin/systemctl
    chmod +x /usr/local/bin/systemctl
    if [ "$TEST_USER" == "ubuntu" ]; then
      if ! id "ubuntu" &>/dev/null; then
        useradd -m -s /bin/bash ubuntu
        echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers || true
      fi
    fi
    SETUP_SCRIPT=$(python3 -c "import json; d=json.load(open('/scenario/index.json')); print(d.get('details', {}).get('intro', {}).get('background', ''))" 2>/dev/null)
    if [ -n "$SETUP_SCRIPT" ] && [ -f "/scenario/$SETUP_SCRIPT" ]; then
      echo "      [INFO] Running setup: $SETUP_SCRIPT"
      bash "/scenario/$SETUP_SCRIPT" > /dev/null 2>&1 || true
    fi
    USER_HOME=$(eval echo "~$TEST_USER")
    python3 <<'PYEOF'
import os, subprocess, re, sys
test_user = os.getenv('TEST_USER')
user_home = os.path.expanduser(f"~{test_user}")
steps = sorted([d for d in os.listdir('/scenario') if d.startswith('step')])
for step in steps:
    step_dir = f"/scenario/{step}"
    step_num = step.replace('step', '')
    text_path = f"{step_dir}/text.md"
    hints = []
    if os.path.exists(text_path):
        with open(text_path, 'r') as f:
            content = f.read()
            details_matches = re.findall(r'<details>.*?</details>', content, re.DOTALL)
            for d in details_matches:
                bash_blocks = re.findall(r'```bash\n(.*?)\n```', d, re.DOTALL)
                hints.extend(bash_blocks)
    if hints:
        hint_script = f"/tmp/hint_{step}.sh"
        with open(hint_script, 'w') as f:
            f.write("#!/bin/bash\ncd " + user_home + "\n" + "\n".join(hints))
        subprocess.run(['su', '-', test_user, '-c', 'bash ' + hint_script], capture_output=True)
    verify_path = f"{step_dir}/verify.sh"
    if os.path.exists(verify_path):
        res = subprocess.run(['bash', verify_path], capture_output=True, text=True, env={**os.environ, 'HOME': user_home, 'USER': test_user})
        if res.returncode != 0:
            print(f"      FAIL step {step_num}")
            print(f"      REASON: {res.stdout} {res.stderr}")
            sys.exit(1)
        else:
            print(f"      PASS step {step_num}")
print("  ALL STEPS PASSED")
PYEOF
INNER_EOF
}

test_scenario() {
  local scenario_dir="$1"; local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"
  [ -f "$index_json" ] || return
  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)
  if [ "$imageid" != "ubuntu" ]; then return; fi
  echo -n "  TEST $name... "
  if test_scenario_as_user "$scenario_dir" "root" "$imageid" && \
     test_scenario_as_user "$scenario_dir" "ubuntu" "$imageid"; then
    echo "PASS"
    PASS=$((PASS + 1))
  else
    echo "FAIL"
    FAIL=$((FAIL + 1))
  fi
}

echo "KubeDojo Lab Scenario Tester"
for arg in "$@"; do
  if [ "$arg" == "--all" ]; then
    for scenario in "$REPO_ROOT"/*-*/; do [ -d "$scenario" ] && test_scenario "$scenario"; done
  else
    test_scenario "$REPO_ROOT/$arg"
  fi
done
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
