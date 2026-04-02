#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/io-benchmark.txt ]; then
  echo "FAIL: $USER_HOME/io-benchmark.txt not found"
  exit 1
fi

if grep -qiE '(MB|GB|bytes|KB)/s' $USER_HOME/io-benchmark.txt; then
  echo "PASS: io-benchmark.txt contains throughput measurement"
  exit 0
else
  echo "FAIL: io-benchmark.txt should contain throughput (MB/s or similar)"
  exit 1
fi
