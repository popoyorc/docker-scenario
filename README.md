# MegaCorp On-Call: The Cascading Incident

A Killercoda scenario for engineers who just learned Docker fundamentals, designed to build
Day-2 operations troubleshooting skills through one continuous, escalating incident rather than
disconnected quizzes.

## Premise

You're the on-call engineer for "MegaCorp." A deploy for `orders-service` just went out, and
five alerts fire in sequence. Fixing one issue reveals the next — mirroring how real incidents
actually cascade.

| Step | Alert | Root Cause | Concept Tested |
|---|---|---|---|
| 1 | Silent Container | Missing env var crashes app on startup | `docker ps -a`, `docker logs` |
| 2 | Unreachable Port | No port mapping at container start | Host vs. container networking, `-p` |
| 3 | 502 Load Balancer | Containers on different Docker networks | Service discovery, `--network` |
| 4 | Vanishing Data | No volume — data lost on redeploy | Volumes, persistence, `-v` |
| 5 | Resource Hog | No CPU/memory limits | `docker stats`, `--cpus`, `--memory` |

## Design principles

- **No exact answers given upfront.** Each step includes 3 tiered hints (collapsed by default):
  a conceptual nudge, a command category, then the exact command/flag.
- **Fundamentals-only vocabulary.** Every hint traces back to commands/flags typically covered
  in a Docker basics course: `docker run`, `ps`, `logs`, `inspect`, `exec`, `-p`, `-v`,
  `--network`, `docker stats`.
- **Outcome-based verification.** `verify*.sh` scripts check the actual result (container
  running, port reachable, data persisted, limits set) rather than requiring one specific
  command — multiple valid fixes pass.
- **~60 minutes total**, suited for a live facilitated session.

## Folder structure

```
megacorp-oncall/
├── index.json           <- scenario config: steps, intro, finish, assets, backend
├── intro.md              <- sets up the story, has learner build the base image first
├── step1.md  + verify1.sh
├── step2.md  + verify2.sh
├── step3.md  + verify3.sh
├── step4.md  + verify4.sh
├── step5.md  + verify5.sh
├── finish.md              <- recap table + closing takeaway
└── assets/                 <- copied onto the VM (host01) at scenario start
    ├── orders-service/
    │   ├── Dockerfile
    │   └── app.py          (crashes without PORT env var — this is Alert 1's bug)
    └── nginx/
        └── nginx.conf       (proxies to orders-service — used in Alert 3)
```

> ⚠️ **Note on asset globs:** avoid wildcard patterns like `**/*.*` for files without an
> extension (e.g. `Dockerfile`) — Killercoda's glob matching requires a dot in the filename, so
> extensionless files get silently skipped. List files explicitly instead, as done in
> `index.json` here.

## How assets map to `index.json`

```json
"assets": {
  "host01": [
    { "file": "orders-service/Dockerfile", "target": "/root/assets/orders-service" },
    { "file": "orders-service/app.py", "target": "/root/assets/orders-service" },
    { "file": "nginx/nginx.conf", "target": "/root/assets/nginx" }
  ]
}
```

These files land at `~/assets/orders-service` and `~/assets/nginx` on the VM before the learner
sees the intro page.

## Before pushing / re-testing

```bash
cd megacorp-oncall
chmod +x verify*.sh
git add .
git commit -m "Update scenario"
git push
```

Then reload the scenario in Killercoda's editor and confirm:

```bash
ls ~/assets/orders-service   # should show Dockerfile and app.py
cd ~/assets/orders-service && docker build -t orders-service-image .
```

Test each step end-to-end (including hints and verify checks) before sharing the scenario link
with a live audience.

## Backend

Uses Killercoda's `"ubuntu"` image (Ubuntu 24.04, 2GB, Docker + Podman pre-installed) — no
Kubernetes needed for this scenario.
