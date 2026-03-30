#!/bin/bash
# Solution: Create user and group
groupadd devteam
useradd -m -s /bin/bash -G devteam developer
id developer
