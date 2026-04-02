#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get service web-svc >/dev/null 2>&1; then echo "FAIL: Service 'web-svc' not found."; exit 1; fi
TYPE=$(kubectl get service web-svc -o jsonpath='{.spec.type}')
if [ "$TYPE" = "ClusterIP" ]; then echo "PASS: ClusterIP service 'web-svc' verified!"; exit 0; fi
echo "FAIL: Service type is $TYPE, expected ClusterIP."
exit 1
