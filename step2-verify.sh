#!/bin/bash
LEGACY=$(docker ps --filter "name=legacy-service" --format '{{.Names}}')
MODERN=$(docker ps --filter "name=modern-service" --format '{{.Names}}')
if [[ -n "$LEGACY" && -n "$MODERN" ]]; then
  echo "Both legacy-service and modern-service are running side by side."
  exit 0
else
  echo "Make sure both legacy-service and modern-service containers are up (docker ps)."
  exit 1
fi
