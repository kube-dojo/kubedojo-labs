#!/bin/bash
kubectl create job countdown --image=busybox:1.36 -n jobs-lab -- sh -c 'for i in 5 4 3 2 1; do echo $i; sleep 1; done; echo Done'
kubectl wait --for=condition=complete job/countdown -n jobs-lab --timeout=60s
POD=$(kubectl get pods -n jobs-lab -l job-name=countdown -o jsonpath='{.items[0].metadata.name}')
kubectl logs "$POD" -n jobs-lab > /root/countdown-logs.txt
