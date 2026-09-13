#!/bin/bash
# Setup for bash fundamentals lab
echo "Setup complete. Ready for bash scripting exercises."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
