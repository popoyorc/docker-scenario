## Step 4 -- Large Scale: Scaling a Service Like a Fleet

**MegaCorp problem:** A release is about to go out. One internal dashboard normally handles
light traffic -- but during release week, thousands of engineers hit it at once. The team needs
to go from 1 instance to many, instantly, without changing any code.

This is where Docker meets **distributed systems** concepts: scheduling, replicas, and resource
allocation across a fleet instead of a single machine.

### Start with one replica

    cd ~/assets/scale
    docker compose up -d --build
    docker compose ps

### Now scale it up, the way MegaCorp would during a launch

    docker compose up -d --scale web=5
    docker compose ps

You now have 5 identical, isolated instances of the same service, all scheduled by Docker on
your single sandbox. In a real MegaCorp environment, this exact concept -- just handled by an
orchestrator like Kubernetes or Docker Swarm across hundreds of physical servers instead of one
sandbox -- is how a service goes from handling 100 requests/sec to 100,000 requests/sec.

Check resource usage across every replica at once:

    docker stats --no-stream

### Discussion point

Ask yourself: *if these 5 replicas were spread across 5 different physical servers instead of
one sandbox, what would need to happen for traffic to reach all of them evenly?* (Answer:
that's exactly the job of a load balancer / orchestrator service mesh -- the next layer up from
what you just did.)

**Click Check once you see 5 running `web` replicas.**
