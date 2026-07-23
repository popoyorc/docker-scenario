#!/bin/bash
RESPONSE=$(curl -s http://localhost:5000)

if echo "$RESPONSE" | grep -q "orders-service is healthy"; then
  echo "Reachable! Port mapping is fixed."
  exit 0
else
  echo "Still not reachable on port 5000. Check the container's port mapping with docker inspect."
  exit 1
fi
