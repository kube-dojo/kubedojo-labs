#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/system-report.html ]; then
  echo "FAIL: $USER_HOME/system-report.html not found"
  exit 1
fi

ERRORS=0
for tag in "<html" "<h1" "<h2" "<pre" "$(hostname)"; do
  if ! grep -qi "$tag" $USER_HOME/system-report.html; then
    echo "WARN: Missing expected content: $tag"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ "$ERRORS" -le 1 ]; then
  echo "PASS: HTML report contains expected structure and content"
  exit 0
else
  echo "FAIL: HTML report is missing $ERRORS expected elements"
  exit 1
fi
