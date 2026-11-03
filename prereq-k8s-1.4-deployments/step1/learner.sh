#!/bin/bash
# expect-exit: 0
kubectl create deployment webapp --image=nginx:1.25 --replicas=3
