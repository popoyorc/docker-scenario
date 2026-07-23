#!/bin/bash
if ! docker image inspect megacorp/good:1.0 &>/dev/null; then
  echo "Build the optimized image first: docker build -t megacorp/good:1.0 ~/assets/good"
  exit 1
fi

SIZE=$(docker image inspect megacorp/good:1.0 --format='{{.Size}}')
LIMIT=200000000

if [ "$SIZE" -lt "$LIMIT" ]; then
  echo "Great! megacorp/good:1.0 is under 200MB (actual: $SIZE bytes)."
  exit 0
else
  echo "megacorp/good:1.0 is still large ($SIZE bytes). Check base image and multi-stage build."
  exit 1
fi
