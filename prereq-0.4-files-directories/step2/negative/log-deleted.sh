#!/bin/bash
# Leave only requirement log-deleted unmet after replaying the earlier steps.
set -e
rm -r ~/lab-workspace/to_delete_dir/
rm ~/lab-workspace/docs/drafts/tmp_file.log
mkdir ~/lab-workspace/docs/drafts/tmp_file.log
