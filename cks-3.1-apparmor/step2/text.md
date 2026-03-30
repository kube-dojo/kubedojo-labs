# Apply AppArmor Profiles to Pods

Apply the loaded AppArmor profile to a Kubernetes pod.

## Task

1. Create a pod named `apparmor-pod` in `apparmor-lab` namespace with:
   - Image: `nginx`
   - AppArmor profile `k8s-deny-write` applied to the container
   - Use the `securityContext.appArmorProfile` field (K8s 1.30+) or the annotation `container.apparmor.security.beta.kubernetes.io/<container-name>: localhost/k8s-deny-write`
2. Wait for the pod to be running.
3. Test that writing to `/tmp/test` fails inside the pod. Save the result to `/root/write-test.txt`.
4. Verify the pod is using the AppArmor profile. Save the pod's security context or annotation to `/root/pod-apparmor.txt`.

## Hint

For Kubernetes < 1.30, use annotation: `container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-deny-write`. For 1.30+, use `securityContext.appArmorProfile.type: Localhost` with `localhostProfile: k8s-deny-write`.
