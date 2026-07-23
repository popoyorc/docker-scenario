#!/bin/bash
STATUS=$(docker inspect -f '{{.State.Running}}' orders-service 2>/dev/null)

if [ "$STATUS" == "true" ]; then
  echo "orders-service is up and running. Nice work."
  exit 0
else
  echo "orders-service isn't running yet. Check 'docker ps -a' and 'docker logs orders-service'."
  exit 1
fi
