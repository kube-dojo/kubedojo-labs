#!/bin/bash
# Setup for the Software and Packages lab. Idempotent: safe to run repeatedly.

# Evidence directory for verifiers.
rm -rf /tmp/kd-pkg
mkdir -p /tmp/kd-pkg
chmod 1777 /tmp/kd-pkg

# Remove the lab's target packages so installs are real (ignore if absent).
apt-get remove -y -qq htop tree > /dev/null 2>&1 || true

# Make the package catalog stale on purpose: a fresh server looks like this,
# and step 1 teaches why 'apt update' must come first.
rm -rf /var/lib/apt/lists/*

# Seed the practice directory from the curriculum's earlier modules.
seed_practice() {
  local home_dir=$1 owner=$2
  local base="$home_dir/kubedojo-practice/recipes"
  mkdir -p "$base/appetizers" "$base/desserts" "$base/main-courses"
  echo "Toasted bread, tomatoes, garlic, basil." > "$base/appetizers/bruschetta.txt"
  echo "Coffee, mascarpone, ladyfingers, cocoa." > "$base/desserts/tiramisu.txt"
  echo "Pasta, eggs, pecorino, guanciale, pepper." > "$base/main-courses/pasta-carbonara.txt"
  chown -R "$owner:$owner" "$home_dir/kubedojo-practice" 2>/dev/null || true
}
seed_practice /root root
if [ -d /home/ubuntu ]; then
  seed_practice /home/ubuntu ubuntu
fi

echo "Setup complete."
