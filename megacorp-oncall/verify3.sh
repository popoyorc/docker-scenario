#!/bin/bash
RESPONSE=$(curl -s http://localhost:8080)

if echo "$RESPONSE" | grep -q "orders-service is healthy"; then
  echo "The load balancer can now reach orders-service. Networking fixed!"
  exit 0
else
  echo "Still getting a 502. Check that both containers are on the same Docker network."
  exit 1
fi
