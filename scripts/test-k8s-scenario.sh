#!/bin/bash
# Test K8s Killercoda scenarios locally using kind
#
# Usage: ./scripts/test-k8s-scenario.sh prereq-k8s-1.1-first-cluster
#        ./scripts/test-k8s-scenario.sh --all
#
# Requires: docker, kind, kubectl

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLUSTER_NAME="kubedojo-test"
PASS=0
FAIL=0

ensure_cluster() {
  if kind get clusters 2>/dev/null | grep -q "$CLUSTER_NAME"; then
    echo "  Using existing kind cluster: $CLUSTER_NAME"
  else
    echo "  Creating kind cluster: $CLUSTER_NAME"
    kind create cluster --name "$CLUSTER_NAME" --wait 60s 2>/dev/null
  fi
}

cleanup_cluster() {
  echo ""
  echo "Cleaning up kind cluster..."
  kind delete cluster --name "$CLUSTER_NAME" 2>/dev/null || true
}

test_scenario() {
  local scenario_dir="$1"
  local name=$(basename "$scenario_dir")
  local index_json="$scenario_dir/index.json"

  if [ ! -f "$index_json" ]; then
    return
  fi

  local imageid=$(python3 -c "import json; print(json.load(open('$index_json'))['backend']['imageid'])" 2>/dev/null)

  if [ "$imageid" != "kubernetes-kubeadm-1node" ]; then
    return
  fi

  echo "  TEST $name"

  # Copy scenario into the kind control plane node
  local node="${CLUSTER_NAME}-control-plane"
  docker exec "$node" mkdir -p /scenario
  docker cp "$scenario_dir/." "$node:/scenario/"
  docker exec "$node" chmod +x /scenario/setup.sh /scenario/step*/solution.sh /scenario/step*/verify.sh 2>/dev/null || true

  # Run setup inside the node
  docker exec "$node" bash /scenario/setup.sh 2>/dev/null || true

  # Run solution + verify per step (inside the node)
  local steps=$(ls -d "$scenario_dir"/step*/ 2>/dev/null | sort)
  local step_num=0
  local failed=false

  for step_dir in $steps; do
    step_num=$((step_num + 1))
    local step_name=$(basename "$step_dir")

    # Run per-step solution inside the node
    if [ -f "$step_dir/solution.sh" ]; then
      docker exec "$node" bash "/scenario/$step_name/solution.sh" 2>/dev/null || true
    fi

    # Verify inside the node
    if [ -f "$step_dir/verify.sh" ]; then
      if docker exec "$node" bash "/scenario/$step_name/verify.sh" 2>/dev/null; then
        echo "    PASS step $step_num"
      else
        echo "    FAIL step $step_num"
        failed=true
        break
      fi
    fi
  done

  if [ "$failed" = true ]; then
    echo "  FAIL $name"
    FAIL=$((FAIL + 1))
  else
    echo "  ALL STEPS PASSED"
    PASS=$((PASS + 1))
  fi

  # Clean up K8s resources between scenarios
  kubectl delete all --all -n default 2>/dev/null || true
  kubectl delete all --all -n practice 2>/dev/null || true
  kubectl delete namespace practice my-first-ns 2>/dev/null || true
}

echo "========================================="
echo "KubeDojo K8s Scenario Tester (kind)"
echo "========================================="
echo ""

ensure_cluster

trap cleanup_cluster EXIT

if [ "${1:-}" = "--all" ]; then
  for scenario in "$REPO_ROOT"/prereq-k8s-*/ "$REPO_ROOT"/cka-*/ "$REPO_ROOT"/ckad-*/ "$REPO_ROOT"/cks-*/; do
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
echo "Results: $PASS passed, $FAIL failed"
echo "========================================="

[ "$FAIL" -eq 0 ] || exit 1
