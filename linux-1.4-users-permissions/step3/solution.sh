#!/bin/bash
# Solution: Configure sudo for developer (apt only)
echo 'developer ALL=(ALL) /usr/bin/apt' | sudo tee /etc/sudoers.d/developer > /dev/null
sudo chmod 440 /etc/sudoers.d/developer
echo 'developer ALL=(ALL) /usr/bin/apt' > "$HOME"/sudo-rule.txt
cat "$HOME"/sudo-rule.txt
