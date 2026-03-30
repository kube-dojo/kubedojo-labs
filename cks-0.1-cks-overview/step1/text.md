# Explore the CKS Exam Environment and Security Tools

The CKS exam provides a Kubernetes cluster with various security tools pre-installed. Familiarize yourself with the available tools and cluster state.

## Task

1. Check the Kubernetes version and save it to `/root/k8s-version.txt`.
2. Verify that the following security-relevant components are accessible:
   - `kubectl` with autocompletion
   - The API server's security-related flags
3. List all namespaces and save them to `/root/namespaces.txt`.
4. Examine the API server manifest at `/etc/kubernetes/manifests/kube-apiserver.yaml` and save any `--enable-admission-plugins` value to `/root/admission-plugins.txt`.

## Hint

Check `kubectl version --short` and examine static pod manifests under `/etc/kubernetes/manifests/`.
