#!/bin/bash
# Create some files for the user to explore
mkdir -p /home/user/documents /home/user/projects /home/user/downloads
echo "Hello from KubeDojo!" > /home/user/documents/welcome.txt
echo "Kubernetes is an open-source container orchestration platform." > /home/user/documents/kubernetes.txt
echo "Docker is a containerization technology." > /home/user/documents/docker.txt
echo -e "apple\nbanana\ncherry\ndate\nelderberry" > /home/user/documents/fruits.txt
echo -e "nginx:running\npostgres:stopped\nredis:running\napi:running\nworker:stopped" > /home/user/documents/services.txt
