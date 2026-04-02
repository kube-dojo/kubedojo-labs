#!/bin/bash
for user_home in /root /home/ubuntu; do
  if [ -d "$user_home" ]; then
    mkdir -p "$user_home/documents" "$user_home/projects" "$user_home/downloads"
    echo "Hello from KubeDojo! Your secret code is: DOJO123" > "$user_home/documents/welcome.txt"
    echo "Kubernetes is an open-source container orchestration platform." > "$user_home/documents/kubernetes.txt"
    echo "Docker is a containerization technology." > "$user_home/documents/docker.txt"
    echo -e "apple\nbanana\ncherry\ndate\nelderberry" > "$user_home/documents/fruits.txt"
    echo -e "nginx:running\npostgres:stopped\nredis:running\napi:running\nworker:stopped" > "$user_home/documents/services.txt"
    if [ "$user_home" == "/home/ubuntu" ]; then
      chown -R ubuntu:ubuntu "$user_home" 2>/dev/null || true
    fi
  fi
done
