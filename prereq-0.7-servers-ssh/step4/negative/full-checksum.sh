#!/bin/bash
# Leave only requirement full-checksum unmet after replaying the earlier steps.
set -e
md5sum ~/important-data.bin | cut -d ' ' -f 1 > ~/checksum.txt
