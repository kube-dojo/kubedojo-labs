#!/bin/bash
cat <<YAML | kubectl apply -f -
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
YAML
echo "backupjobs.stable.example.com" > /root/crd-name.txt
