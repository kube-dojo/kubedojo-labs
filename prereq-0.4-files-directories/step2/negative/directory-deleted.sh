#!/bin/bash
# Leave only requirement directory-deleted unmet after replaying the earlier steps.
set -e
rm ~/lab-workspace/docs/drafts/tmp_file.log
rm -r ~/lab-workspace/to_delete_dir/
echo retained > ~/lab-workspace/to_delete_dir
