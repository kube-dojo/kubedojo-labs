#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/dig-output.txt exists and contains dig output
if [ ! -f $USER_HOME/dig-output.txt ]; then
  echo "FAIL: $USER_HOME/dig-output.txt does not exist"
  exit 1
fi

# Check for ANSWER SECTION or an IP address in the output
if grep -q "ANSWER SECTION" $USER_HOME/dig-output.txt; then
  echo "PASS: File contains dig ANSWER SECTION"
  exit 0
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' $USER_HOME/dig-output.txt; then
  echo "PASS: File contains an IP address"
  exit 0
fi

echo "FAIL: $USER_HOME/dig-output.txt does not contain expected dig output"
exit 1
