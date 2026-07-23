## Step 5 -- Facilitate: Fix the Broken Deployment

**MegaCorp problem:** An on-call engineer (you) just got paged. A service was deployed but a
health check is failing. Nobody wants to roll back -- they want you to find the misconfiguration
and fix it, fast.

There's a broken `docker-compose.yml` waiting for you. It defines two services:
- `api` -- a small backend that should be reachable
- `lb` -- an nginx load balancer that should forward traffic to `api`

But it's broken. Your job: find the bug(s) and get it working.

    cd ~/assets/challenge
    cat docker-compose.yml

Try bringing it up and testing it:

    docker compose up -d --build
    curl http://localhost:8080

It won't work yet. Investigate:

    docker compose ps
    docker compose logs

**Hints (only look if stuck):**
- Check whether the port the `api` container *actually listens on* matches the port mapping.
- Check whether `lb` and `api` are on a network together -- can `lb` even resolve the hostname
  `api`?

Fix the `docker-compose.yml` file directly (you can use `vi`, `nano`, or your terminal's editor),
then re-run:

    docker compose up -d --build
    curl http://localhost:8080

You should see: `Hello from the API!`

**Click Check once the curl succeeds.**
