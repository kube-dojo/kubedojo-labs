#!/bin/bash
# text.md:2-3
# expect-exit: 0
sudo service nginx start
# expect-exit: 0
ss -tlnp > ~/ports.txt
