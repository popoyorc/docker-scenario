#!/bin/bash
if ! docker volume inspect orders-data &>/dev/null; then
  echo "No 'orders-data' volume found yet. Create one and mount it into the container."
  exit 1
fi

CONTENT=$(docker exec orders-service cat /app/data/orders.log 2>/dev/null)

if echo "$CONTENT" | grep -q "order #1234"; then
  echo "Data survived! Volume is correctly configured."
  exit 0
else
  echo "orders.log isn't there yet. Make sure it's written inside the mounted volume path."
  exit 1
fi
