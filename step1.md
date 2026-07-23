## Step 1 -- Glimpse: Your First Container

**MegaCorp problem:** A new engineer joins and needs to confirm their dev environment even
works, without touching anything real yet.

Run a tiny, throwaway container. It downloads, runs, prints something, and exits -- just like
a script, but fully isolated from your host machine:

    docker run rancher/cowsay MegaCorp

Now check what happened to it:

    docker ps -a

Notice the container shows `Exited (0)` -- it did its job and stopped. That's completely normal
for a one-shot task (think: a CI job, a batch script, a data migration task).

### Now the "wow" moment

Run a **long-running** service instead -- a real web server:

    docker run -d -p 8888:80 --name my-first-service nginx

- `-d` = run in the background (detached)
- `-p 8888:80` = map port 8888 on your sandbox to port 80 inside the container

Check it's alive:

    docker ps
    curl localhost:8888

You just went from "nothing installed" to "a web server running" in two commands, with zero
risk to the host machine. That's the entire reason MegaCorp's new-hire onboarding time dropped
from days to minutes.

**Click Check when you're ready to move on.**
