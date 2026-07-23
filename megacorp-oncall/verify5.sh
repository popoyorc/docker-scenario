#!/bin/bash
if ! docker inspect load-test &>/dev/null; then
  echo "load-test container not found. Start it with --cpus and --memory limits."
  exit 1
fi

NANO_CPUS=$(docker inspect load-test --format '{{.HostConfig.NanoCpus}}')
MEMORY=$(docker inspect load-test --format '{{.HostConfig.Memory}}')

if [ "$NANO_CPUS" != "0" ] && [ "$MEMORY" != "0" ]; then
  echo "load-test now has both CPU and memory limits set. Resource limits fixed!"
  exit 0
else
  echo "load-test is missing a CPU or memory limit. Recreate it with --cpus and --memory."
  exit 1
fi
