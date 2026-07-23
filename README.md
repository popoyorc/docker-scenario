# Docker Scenario — Killercoda Structure

This follows Killercoda's **official** convention (verified against
[killercoda/scenario-examples](https://github.com/killercoda/scenario-examples)): each step
lives in its own folder containing `text.md` (instructions) and `verify.sh` (the check that
runs when the learner clicks "Check").

## Folder tree

```
docker-scenario/
├── index.json              <- scenario config: steps, intro, finish, assets, backend
├── intro/
│   └── text.md              <- shown before Step 1
├── step1/
│   ├── text.md
│   └── verify.sh
├── step2/
│   ├── text.md
│   └── verify.sh
├── step3/
│   ├── text.md
│   └── verify.sh
├── step4/
│   ├── text.md
│   └── verify.sh
├── step5/
│   ├── text.md
│   └── verify.sh
├── finish/
│   └── text.md               <- shown after the last step
└── assets/                    <- files copied onto the VM (host01) at scenario start
    ├── bad/                   -> copied to /root/assets/bad
    ├── good/                  -> copied to /root/assets/good
    ├── scale/                 -> copied to /root/assets/scale
    └── challenge/             -> copied to /root/assets/challenge
```

## How each piece maps to `index.json`

| Key in index.json | File(s) | Purpose |
|---|---|---|
| `details.intro.text` | `intro/text.md` | Landing page before Step 1 |
| `details.steps[n].text` | `stepN/text.md` | Instructions shown for that step |
| `details.steps[n].verify` | `stepN/verify.sh` | Script Killercoda runs when learner clicks "Check" |
| `details.finish.text` | `finish/text.md` | Wrap-up page |
| `details.assets.host01` | everything under `assets/` | Files copied to the VM before the scenario starts. Paths are relative to the `assets/` folder itself (e.g. `bad/**/*.*`, not `assets/bad/**/*.*`) |
| `backend.imageid` | — | `"ubuntu"` — Killercoda's standard Ubuntu backend, which comes with Docker pre-installed |

## Before uploading to Killercoda / GitHub

1. Make all verify scripts executable:
   ```bash
   chmod +x */verify.sh
   ```
2. Confirm asset paths in each `stepN/text.md` match where `index.json` places them
   (`/root/assets/...`).
3. Push this whole `docker-scenario/` folder to the GitHub repo linked to your Killercoda
   scenario, then open the scenario in **Edit mode** on Killercoda to do a live test run before
   your session.
4. Test every step end-to-end yourself, including the verify checks, before sharing the link
   with your 70 attendees.
