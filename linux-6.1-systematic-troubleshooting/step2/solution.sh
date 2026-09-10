#!/bin/bash
# Solution: Find failed service
echo "broken-app.service" > "$HOME"/failed-service.txt
systemctl status broken-app.service
