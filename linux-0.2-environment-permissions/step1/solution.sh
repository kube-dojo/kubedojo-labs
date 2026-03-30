#!/bin/bash
# Solution: Set and persist environment variables
echo 'export MY_APP=/opt/myapp' >> ~/.bashrc
echo 'export PATH="/opt/myapp/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
echo "MY_APP=$MY_APP"
echo "PATH=$PATH"
