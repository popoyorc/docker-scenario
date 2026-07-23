## Step 3 -- Best Practices: Fixing a Bloated Image

**MegaCorp problem:** A team ships a container image that's 2.7GB. Builds are slow, deploys are
slow, and every rollout to thousands of servers wastes bandwidth and time. Your job: diagnose it
and fix it, the same way you'd be asked to in a real code review.

### First, build the "bad" version

    cd ~/assets/bad
    docker build -t megacorp/bad:1.0 .
    docker images megacorp/bad

Take note of the size. This Dockerfile has several classic problems:
- A full `ubuntu` base image instead of something minimal
- Build tools (`build-essential`, `git`, `vim`, `curl`) left in the final image
- Everything running as `root`
- No multi-stage build -- build-time junk ships to production

### Now build the "good" version

    cd ~/assets/good
    docker build -t megacorp/good:1.0 .
    docker images megacorp/good

This version:
- Uses a slim base image (`python:3.12-slim`)
- Uses a **multi-stage build** so build tools never reach the final image
- Runs as a **non-root user**
- Ships nothing that isn't needed at runtime

### Compare

    docker images | grep megacorp

Talk through the size difference. In a real deploy pipeline, this difference is the gap
between a 30-second rollout and a 10-minute one, multiplied across thousands of servers.

**Click Check once `megacorp/good:1.0` is built.**
