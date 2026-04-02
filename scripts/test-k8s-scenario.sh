#!/bin/bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLUSTER_NAME="kubedojo-test"
PASS=0; FAIL=0

ensure_cluster() {
  if kind get clusters 2>/dev/null | grep -q "$CLUSTER_NAME"; then
    echo "  Using existing kind cluster: $CLUSTER_NAME"
  else
    echo "  Creating kind cluster: $CLUSTER_NAME"
    kind create cluster --name "$CLUSTER_NAME" --wait 60s
  fi
}

test_scenario() {
  local scenario_dir="$1"; local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"
  [ -f "$index_json" ] || return
  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)
  [ "$imageid" = "kubernetes-kubeadm-1node" ] || return
  
  echo "  TEST $name"
  local node="${CLUSTER_NAME}-control-plane"
  
  # Prepare node
  docker exec "$node" mkdir -p /scenario
  docker cp "$scenario_dir/." "$node:/scenario/"
  
  # Run setup
  echo "    Running setup..."
  docker exec "$node" bash /scenario/setup.sh
  
  local steps=$(ls -d "$scenario_dir"/step*/ 2>/dev/null | sort)
  local step_num=0; local failed=false
  for step_dir in $steps; do
    step_num=$((step_num + 1)); local step_name=$(basename "$step_dir")
    echo "    Step $step_num..."
    
    local local_hint="/tmp/hint_${name}_step${step_num}.sh"
    echo "#!/bin/bash" > "$local_hint"
    if [ -f "$step_dir/text.md" ]; then
      sed -n '/<details>/,/<\/details>/p' "$step_dir/text.md" | sed -n '/^```bash/,/^```/p' | grep -v '^```' >> "$local_hint" || true
    fi
    
    if grep -cvE '^$|^#!/bin/bash' "$local_hint" &>/dev/null; then
      echo "      Running hint..."
      docker cp "$local_hint" "$node:/root/hint.sh"
      docker exec "$node" bash /root/hint.sh
    elif [ -f "$step_dir/solution.sh" ]; then
      echo "      Running solution.sh..."
      docker exec "$node" bash "/scenario/$step_name/solution.sh"
    fi
    
    if [ -f "$step_dir/verify.sh" ]; then
      if docker exec "$node" bash "/scenario/$step_name/verify.sh" > /tmp/v_out.log 2>&1; then
        echo "      PASS verify"
      else
        echo "      FAIL verify"
        echo "      REASON:"
        cat /tmp/v_out.log
        failed=true; break
      fi
    fi
  done
  
  [ "$failed" = true ] && FAIL=$((FAIL + 1)) || { echo "  ALL STEPS PASSED"; PASS=$((PASS + 1)); }
  
  kubectl delete all --all -n default >/dev/null 2>&1 || true
  kubectl delete all --all -n practice >/dev/null 2>&1 || true
  kubectl delete namespace practice my-first-ns >/dev/null 2>&1 || true
}

ensure_cluster
if [ "${1:-}" = "--all" ]; then
  for s in "$REPO_ROOT"/prereq-k8s-*/; do test_scenario "$s"; done
else
  test_scenario "$REPO_ROOT/$1"
fi
echo -e "\nResults: $PASS passed, $FAIL failed"
