# Create a Base Kustomization

## Task

1. Create directory `"$HOME"/kustomize/base/`.
2. Create `"$HOME"/kustomize/base/deployment.yaml`:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: myapp
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: myapp
     template:
       metadata:
         labels:
           app: myapp
       spec:
         containers:
         - name: myapp
           image: nginx:1.25
           ports:
           - containerPort: 80
   ```
3. Create `"$HOME"/kustomize/base/service.yaml`:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: myapp
   spec:
     selector:
       app: myapp
     ports:
     - port: 80
       targetPort: 80
   ```
4. Create `"$HOME"/kustomize/base/kustomization.yaml`:
   ```yaml
   resources:
   - deployment.yaml
   - service.yaml
   ```
5. Build and verify: `kubectl kustomize "$HOME"/kustomize/base/` — save output to `"$HOME"/base-output.yaml`.

## Hint

`kubectl kustomize <dir>` renders the kustomization without applying it.
