# Incident Resolved 🎉

You just handled a full on-call shift, start to finish:

| Alert | Root cause | Concept |
|---|---|---|
| 1. Silent Container | Missing env var crashed the app on startup | `docker ps -a`, `docker logs` |
| 2. Unreachable Port | No port mapping (`-p`) at container start | Host vs. container networking |
| 3. 502 Load Balancer | Containers on different Docker networks | Service discovery / shared networks |
| 4. Vanishing Data | No volume -- data lived only in the container's writable layer | Volumes, persistence |
| 5. Resource Hog | No CPU/memory limits -- one container starved the rest | `docker stats`, `--cpus`, `--memory` |

Every one of these is a real pattern that shows up daily at companies running containers at
scale -- the only thing that changes as systems grow bigger is *who* fixes it (you, an
orchestrator, an auto-remediation system) and *how many* containers are affected at once.

**Take this with you:** the next time something "just doesn't work," ask which of these five
categories it might fall into -- startup failure, networking, service discovery, persistence, or
resource contention. That mental checklist covers a huge percentage of real container issues.
