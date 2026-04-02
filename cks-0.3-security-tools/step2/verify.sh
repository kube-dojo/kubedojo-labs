#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in trivy-nginx-old.txt trivy-nginx-latest.txt critical-count.txt trivy-report.json; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! python3 -c "import json; json.load(open('$USER_HOME/trivy-report.json'))" 2>/dev/null; then
  echo "FAIL: trivy-report.json is not valid JSON"
  exit 1
fi
echo "PASS"
exit 0
