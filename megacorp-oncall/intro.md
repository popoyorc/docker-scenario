# MegaCorp On-Call: The Cascading Incident

You're the on-call engineer for **MegaCorp**. A deploy for `orders-service` just went out.

Within 10 minutes, five different alerts fire, one after another. As soon as you fix one thing,
the next problem shows up -- this is exactly how real incidents feel. You'll fix five separate
issues, each one building on the last.

You just finished learning Docker fundamentals. That's genuinely all you need for this. Every
hint in this scenario only points back to commands and flags you've already learned:
`docker run`, `docker ps`, `docker logs`, `docker inspect`, `docker exec`, `-p`, `-v`,
`--network`, `docker stats`.

**How hints work:** each step has 3 hints, hidden by default. Try to reason through the problem
first -- but if you're stuck for more than a few minutes, open Hint 1, then Hint 2, then Hint 3
if you still need it. Hint 3 will always name the exact command or flag.

## Before you start: build the image

The `orders-service` app is already sitting in `~/assets/orders-service`. Build it once, and
you'll use this same image throughout the whole incident:

    cd ~/assets/orders-service
    docker build -t orders-service-image .

Once the build finishes, click **Start**. Good luck -- the pager just went off.
