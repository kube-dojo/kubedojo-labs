#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep -E '(max-requests|max-mutating)' "$MANIFEST" > /root/rate-limits.txt || echo "Using defaults: max-requests-inflight=400, max-mutating-requests-inflight=200" > /root/rate-limits.txt
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -E '(max-requests|max-mutating)' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/rate-limits.txt 2>/dev/null || echo "Using defaults: max-requests-inflight=400, max-mutating-requests-inflight=200" > /root/rate-limits.txt
  else
    echo "Using defaults: max-requests-inflight=400, max-mutating-requests-inflight=200" > /root/rate-limits.txt
  fi
fi

cat > /root/rate-limit-docs.txt << 'DOCS'
--max-requests-inflight (default 400): Maximum non-mutating requests in flight at a given time
--max-mutating-requests-inflight (default 200): Maximum mutating requests in flight at a given time
These prevent API server overload from excessive requests.
DOCS

cat > /root/event-rate-limit.txt << 'ERL'
EventRateLimit is an admission controller that limits the rate of event creation.
It prevents event storms from overwhelming the API server and etcd.
Configuration: Create an EventRateLimit config file with limits per source (Server, Namespace, User).
Enable via --enable-admission-plugins=EventRateLimit and --admission-control-config-file.
Important for security: prevents DoS via event flooding and reduces etcd write pressure.
ERL

cat > /root/api-hardening-summary.txt << 'SUMMARY'
1. Disable anonymous authentication or restrict anonymous RBAC
2. Use Node+RBAC authorization mode, never AlwaysAllow
3. Enable NodeRestriction admission controller
4. Configure audit logging for all sensitive operations
5. Set up API rate limiting with appropriate inflight request limits
6. Restrict network access to API server with firewalls or private endpoints
7. Rotate and audit certificates and tokens regularly
8. Enable PodSecurity admission controller
SUMMARY
