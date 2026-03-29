#!/bin/bash
# Verify: tmp_file.log deleted, to_delete_dir removed
[ ! -f /home/user/lab-workspace/docs/drafts/tmp_file.log ] && \
[ ! -d /home/user/lab-workspace/to_delete_dir ] && \
exit 0 || exit 1
