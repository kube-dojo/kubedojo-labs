#!/bin/bash
# expect-exit: 0
kubectl expose deployment web --name=web-svc --port=80 --target-port=80
