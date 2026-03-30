#!/bin/bash
cat > /root/image-policy.yaml << 'YAML'
# Example OPA Gatekeeper ConstraintTemplate for image registry restriction
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8sallowedregistries
spec:
  crd:
    spec:
      names:
        kind: K8sAllowedRegistries
      validation:
        openAPIV3Schema:
          type: object
          properties:
            registries:
              type: array
              items:
                type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sallowedregistries
        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not startswith(container.image, input.parameters.registries[_])
          msg := sprintf("Image '%v' is not from an approved registry", [container.image])
        }
YAML

cat > /root/check-images.sh << 'SCRIPT'
#!/bin/bash
APPROVED="docker.io/library/ registry.k8s.io/ quay.io/"
IMAGES=$(kubectl get pods -A -o jsonpath='{range .items[*]}{.spec.containers[*].image}{"\n"}{end}' | sort -u)
NONCOMPLIANT=0
echo "=== Image Compliance Check ==="
while IFS= read -r img; do
  [ -z "$img" ] && continue
  APPROVED_MATCH=0
  for reg in $APPROVED; do
    if echo "$img" | grep -q "^$reg\|^${reg#*/}"; then
      APPROVED_MATCH=1
      break
    fi
  done
  if [ "$APPROVED_MATCH" -eq 0 ]; then
    echo "NON-COMPLIANT: $img"
    NONCOMPLIANT=$((NONCOMPLIANT + 1))
  else
    echo "COMPLIANT: $img"
  fi
done <<< "$IMAGES"
if [ "$NONCOMPLIANT" -gt 0 ]; then
  echo "RESULT: NON-COMPLIANT ($NONCOMPLIANT unapproved images)"
else
  echo "RESULT: COMPLIANT"
fi
SCRIPT
chmod +x /root/check-images.sh
/root/check-images.sh > /root/image-compliance.txt

cat > /root/approved-registries.txt << 'REGS'
registry.k8s.io/ — Official Kubernetes images
docker.io/library/ — Docker Official Images
gcr.io/google-containers/ — Google container images
quay.io/ — Red Hat/Quay registry
your-company.azurecr.io/ — Private company registry
REGS
