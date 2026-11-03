#!/bin/bash
# text.md:3-8
# expect-exit: 0
echo "LOG_LEVEL=info" >> ~/configs/app.env
# expect-exit: 0
echo "DEBUG=false" >> ~/configs/app.env
