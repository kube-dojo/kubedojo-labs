#!/bin/bash
# Detect primary user
if id "ubuntu" &>/dev/null; then
  TARGET_USER="ubuntu"
  USER_HOME="/home/ubuntu"
else
  TARGET_USER="root"
  USER_HOME="/root"
fi

mkdir -p "$USER_HOME/documents" "$USER_HOME/projects" "$USER_HOME/downloads"
echo "Hello from KubeDojo! Your secret code is: DOJO123" > "$USER_HOME/documents/welcome.txt"
echo "Kubernetes is an open-source container orchestration platform." > "$USER_HOME/documents/kubernetes.txt"
echo "Docker is a containerization technology." > "$USER_HOME/documents/docker.txt"
echo -e "apple\nbanana\ncherry\ndate\nelderberry" > "$USER_HOME/documents/fruits.txt"
echo -e "nginx:running\npostgres:stopped\nredis:running\napi:running\nworker:stopped" > "$USER_HOME/documents/services.txt"

chown -R $TARGET_USER:$TARGET_USER "$USER_HOME/documents" "$USER_HOME/projects" "$USER_HOME/downloads" 2>/dev/null || true
