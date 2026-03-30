# Configure ImagePolicyWebhook Admission

The ImagePolicyWebhook admission controller validates images against an external policy service.

## Task

1. Create an ImagePolicyWebhook admission configuration at `/etc/kubernetes/admission/image-policy.yaml`:
   ```yaml
   apiVersion: apiserver.config.k8s.io/v1
   kind: AdmissionConfiguration
   plugins:
   - name: ImagePolicyWebhook
     configuration:
       imagePolicy:
         kubeConfigFile: /etc/kubernetes/admission/image-policy-kubeconfig.yaml
         allowTTL: 50
         denyTTL: 50
         retryBackoff: 500
         defaultAllow: false
   ```
2. Create a kubeconfig file at `/etc/kubernetes/admission/image-policy-kubeconfig.yaml` pointing to a webhook server (use a placeholder URL `https://image-policy.example.com:8443/validate`).
3. Save both files and document in `/root/image-policy-notes.txt`:
   - What `defaultAllow: false` means (deny if webhook is unreachable)
   - The security risk of `defaultAllow: true`

## Hint

Do NOT add this to the API server flags — it would break the cluster without a running webhook. Just create the configuration files.
