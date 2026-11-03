#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
FILE="$USER_HOME/checksum.txt"
python3 - "$FILE" "$USER_HOME/important-data.bin" "$USER_HOME" <<'PY'
import hashlib
import os
from pathlib import Path
import re
import sys

try:
    lines = Path(sys.argv[1]).read_text().splitlines()
    assert len(lines) == 1
    match = re.fullmatch(r"([0-9a-fA-F]{32}) [ *](.+)", lines[0])
    assert match is not None
    digest, filename = match.groups()
    target = Path(sys.argv[2]).resolve()
    assert digest.lower() == hashlib.md5(target.read_bytes(), usedforsecurity=False).hexdigest()
    if filename.startswith("~/"):
        filename = str(Path(sys.argv[3]) / filename[2:])
    if os.path.isabs(filename):
        assert Path(filename).resolve() == target
    else:
        # md5sum preserves relative spelling; capture cwd is not recorded.
        assert Path(filename).name == target.name
except (OSError, ValueError, AssertionError):
    sys.exit(1)
PY
if [ "$?" -eq 0 ]; then echo "PASS"; exit 0; fi
exit 1
