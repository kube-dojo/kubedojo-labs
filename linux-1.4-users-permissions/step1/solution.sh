#!/bin/bash
# Solution: Create user and group
sudo groupadd devteam
sudo useradd -m -s /bin/bash -G devteam developer
id developer
