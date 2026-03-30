# Create a Custom Resource Definition

## Task

1. Create a CRD for a resource called `BackupJob` with:
   ```yaml
   apiVersion: apiextensions.k8s.io/v1
   kind: CustomResourceDefinition
   metadata:
     name: backupjobs.stable.example.com
   spec:
     group: stable.example.com
     versions:
     - name: v1
       served: true
       storage: true
       schema:
         openAPIV3Schema:
           type: object
           properties:
             spec:
               type: object
               properties:
                 schedule:
                   type: string
                 target:
                   type: string
                 retention:
                   type: integer
     scope: Namespaced
     names:
       plural: backupjobs
       singular: backupjob
       kind: BackupJob
       shortNames:
       - bj
   ```
2. Verify the CRD was created:
   ```
   kubectl get crd backupjobs.stable.example.com
   ```
3. Save the CRD name to `/root/crd-name.txt`.

## Hint

CRDs extend the Kubernetes API. Once created, you can use `kubectl get backupjobs` or `kubectl get bj`. See the Kubernetes docs: Custom Resources.
