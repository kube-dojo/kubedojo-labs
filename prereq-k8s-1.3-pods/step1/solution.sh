#!/bin/bash
kubectl run web --image=nginx:1.25
kubectl wait --for=condition=Ready pod/web --timeout=120s
