#!/bin/bash
# Leave only requirement owner-read unmet after replaying the earlier steps.
set -e
chmod u+x ~/lab-workspace/important_script.sh
chmod u-r,o+r ~/lab-workspace/secret_config.cfg
