#!/bin/bash
# text.md:6-7. List the stopped services, then save that list.
# expect-exit: 0
grep "stopped" ~/documents/services.txt
# expect-exit: 0
grep "stopped" ~/documents/services.txt > ~/projects/lab-results/stopped.txt
