#!/bin/bash
# Solution: Find failed service
echo "broken-app.service" > /root/failed-service.txt
systemctl status broken-app.service
