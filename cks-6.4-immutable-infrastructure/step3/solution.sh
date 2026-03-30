#!/bin/bash
cat > /root/immutability-audit.sh << 'SCRIPT'
#!/bin/bash
echo "=== Immutability Audit Report ==="
echo "Date: $(date)"
echo ""

kubectl get pods -A -o json | python3 -c "
import json, sys
data = json.load(sys.stdin)
compliant = 0
non_compliant = 0
for pod in data['items']:
    ns = pod['metadata']['namespace']
    name = pod['metadata']['name']
    for container in pod['spec'].get('containers', []):
        sc = container.get('securityContext', {})
        readonly = sc.get('readOnlyRootFilesystem', False)
        if readonly:
            print(f'COMPLIANT: {ns}/{name}/{container[\"name\"]}')
            compliant += 1
        else:
            print(f'NON-COMPLIANT: {ns}/{name}/{container[\"name\"]}')
            non_compliant += 1
print(f'\n=== Summary: {compliant} compliant, {non_compliant} non-compliant ===')
" 2>/dev/null || echo "Could not parse pod data"
SCRIPT
chmod +x /root/immutability-audit.sh
/root/immutability-audit.sh > /root/immutability-report.txt

cat > /root/immutability-best-practices.txt << 'BEST'
1. Default readOnlyRootFilesystem: true for all containers — use emptyDir for writable paths
2. Use distroless or scratch base images — no shell means no interactive compromise
3. Enforce immutability with PodSecurity admission and custom policies (OPA/Kyverno)
4. Never install packages at runtime — bake everything into the image at build time
5. Use configMaps and secrets for configuration injection — not runtime file writes
6. Monitor for filesystem modification attempts with Falco or audit logging
7. Combine with allowPrivilegeEscalation: false and drop ALL capabilities
8. Test immutable containers in staging — some apps need specific writable paths
BEST
