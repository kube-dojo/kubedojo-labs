#!/bin/bash
# text.md:3. Apply both instructed typo corrections.
# expect-exit: 0
sed -i 's/sever/server/g' ~/configs/nginx.conf
# expect-exit: 0
sed -i 's/listn/listen/g' ~/configs/nginx.conf
