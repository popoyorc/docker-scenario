#!/bin/bash
if docker ps -a --format '{{.Image}}' | grep -q "cowsay" && \
   docker ps --format '{{.Names}}' | grep -q "my-first-service"; then
  echo "Nice! Your one-shot container ran, and your long-running service is up."
  exit 0
else
  echo "Run both commands from Step 1: the cowsay container and the nginx service."
  exit 1
fi
