#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/troubleshooting-report.txt ]; then
  echo "FAIL: $USER_HOME/troubleshooting-report.txt not found"
  exit 1
fi

SECTIONS=0
for keyword in "Problem" "Investigation" "Root Cause|Cause" "Fix|Resolution"; do
  if grep -qiE "$keyword" $USER_HOME/troubleshooting-report.txt; then
    SECTIONS=$((SECTIONS + 1))
  fi
done

if [ "$SECTIONS" -ge 4 ]; then
  echo "PASS: Report has all 4 required sections"
  exit 0
else
  echo "FAIL: Report should have 4 sections (Problem, Investigation, Root Cause, Fix), found $SECTIONS"
  exit 1
fi
