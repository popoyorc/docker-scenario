#!/bin/bash
cd ~/assets/scale 2>/dev/null || exit 1
COUNT=$(docker compose ps --status running --format '{{.Name}}' | grep -c "web")

if [ "$COUNT" -ge 5 ]; then
  echo "You scaled the web service to $COUNT replicas."
  exit 0
else
  echo "Currently only $COUNT web replicas are running. Try: docker compose up -d --scale web=5"
  exit 1
fi
