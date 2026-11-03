#!/bin/bash
# text.md:2-3. The documented absence check returns 1, with empty stdout.
# expect-exit: 0
sudo apt remove -y wget
# expect-exit: 1
which wget > ~/wget-check.txt
