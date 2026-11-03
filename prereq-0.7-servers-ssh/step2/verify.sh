#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/ports.txt"
# running: nginx must be active independently of the saved output.
pgrep -x nginx >/dev/null || exit 1
# A saved snapshot may contain privileged process columns and historical PIDs.
# Check the table and required listeners without comparing it to a new snapshot.
python3 - "$FILE" <<'PY'
from pathlib import Path
import subprocess
import sys

try:
    lines = Path(sys.argv[1]).read_text().splitlines()
    header = lines[0]
    assert all(label in header for label in
               ("State", "Recv-Q", "Send-Q", "Local Address:Port", "Peer Address:Port", "Process"))
    ports = set()
    for line in lines[1:]:
        fields = line.split()
        assert len(fields) >= 5 and fields[0] == "LISTEN"
        assert fields[1].isdigit() and fields[2].isdigit()
        ports.add(fields[3].rsplit(":", 1)[1])
    assert "80" in ports
    current = subprocess.check_output(["ss", "-H", "-tln"], text=True)
    if any(row.split()[3].endswith(":22") for row in current.splitlines() if len(row.split()) >= 5):
        assert "22" in ports
except subprocess.SubprocessError:
    sys.exit(2)
except (OSError, ValueError, IndexError, AssertionError):
    sys.exit(1)
PY
if [ "$?" -eq 0 ]; then echo "PASS"; exit 0; fi
exit 1
