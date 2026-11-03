#!/bin/bash
# Leave only requirement owner-execute unmet after replaying the earlier steps.
set -e
chmod u-x,o+x ~/lab-workspace/important_script.sh
chmod u+r ~/lab-workspace/secret_config.cfg
