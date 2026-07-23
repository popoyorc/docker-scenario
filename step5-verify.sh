#!/bin/bash
RESPONSE=$(curl -s http://localhost:8080)

if echo "$RESPONSE" | grep -q "Hello from the API"; then
  echo "You fixed it! The load balancer can now reach the API."
  exit 0
else
  echo "Not reachable yet. Check the api port mapping and the shared network in docker-compose.yml."
  exit 1
fi
