#!/bin/bash
kubectl explain pod.spec > "$HOME"/pod-spec-fields.txt
echo "Saved pod.spec fields to $HOME/pod-spec-fields.txt"
head -20 "$HOME"/pod-spec-fields.txt
