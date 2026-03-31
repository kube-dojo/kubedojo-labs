#!/bin/bash
kubectl get clusterrolebindings -o wide 2>/dev/null | grep cluster-admin > /root/cluster-admin-bindings.txt || echo "No cluster-admin bindings" > /root/cluster-admin-bindings.txt

kubectl get clusterrolebindings -o jsonpath='{range .items[?(@.roleRef.name=="cluster-admin")]}{range .subjects[?(@.kind=="ServiceAccount")]}{.namespace}/{.name}{"\n"}{end}{end}' > /root/overprivileged-sa.txt 2>/dev/null || echo "None found" > /root/overprivileged-sa.txt
[ -s /root/overprivileged-sa.txt ] || echo "None found" > /root/overprivileged-sa.txt

kubectl get rolebindings,clusterrolebindings -A -o wide 2>/dev/null | grep secret-admin > /root/secret-admin-audit.txt || echo "No bindings found for secret-admin" > /root/secret-admin-audit.txt

cat > /root/rbac-risks.txt << 'RISKS'
ServiceAccounts with cluster-admin access can perform any action cluster-wide
Roles with wildcard verbs (*) or resources (*) grant excessive permissions
ClusterRoleBindings giving namespace ServiceAccounts cluster-wide access
Roles that allow create/update on Roles or ClusterRoles enable privilege escalation
Bindings to the default ServiceAccount affect all pods in the namespace
RISKS
