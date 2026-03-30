#!/bin/bash
helm upgrade web-app bitnami/nginx -n helm-lab --set replicaCount=2
helm history web-app -n helm-lab
helm rollback web-app 1 -n helm-lab
helm list -n helm-lab -o json | python3 -c "import sys,json; data=json.load(sys.stdin); print([r['revision'] for r in data if r['name']=='web-app'][0])" > /root/helm-revision.txt 2>/dev/null || helm list -n helm-lab | grep web-app | awk '{print $3}' > /root/helm-revision.txt
