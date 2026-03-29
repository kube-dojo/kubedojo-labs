#!/bin/bash
# Verify: relative_test.txt in docs/drafts, absolute_test.txt in /tmp
[ -f /home/user/lab-workspace/docs/drafts/relative_test.txt ] && \
[ -f /tmp/absolute_test.txt ] && \
exit 0 || exit 1
