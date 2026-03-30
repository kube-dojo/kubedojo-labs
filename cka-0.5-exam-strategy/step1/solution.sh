#!/bin/bash
cat > /root/bookmarks.txt << 'EOF'
https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/
https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/deployment-v1/
https://kubernetes.io/docs/concepts/services-networking/service/
https://kubernetes.io/docs/reference/access-authn-authz/rbac/
EOF
echo "Bookmarks saved:"
cat /root/bookmarks.txt
