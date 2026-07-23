## Alert 5: "Since this deploy, every other service on the host has slowed to a crawl."

One more alert comes in. A "test load" container was started earlier to simulate traffic, and
now it's eating every resource on the machine.

Start it (this is deliberately heavy):

    docker run -d --name load-test --cpus 0 progrium/stress --cpu 4 --timeout 300s

Check what's happening on the host:

    docker stats --no-stream

Notice `load-test` consuming way more than its fair share. If two containers share the same
machine, what normally stops one from hogging everything?

<details>
<summary>Hint 1</summary>

If containers share the same computer's CPU and memory, what would you add when starting a
container to cap how much of the machine it's allowed to use?

</details>

<details>
<summary>Hint 2</summary>

You've already used `docker stats` to see live resource usage per container. Now think about
which flags on `docker run` set a *limit* instead of just showing usage.

</details>

<details>
<summary>Hint 3</summary>

Stop the unrestricted container and start it again with limits:

    docker rm -f load-test
    docker run -d --name load-test --cpus 0.5 --memory 256m progrium/stress --cpu 4 --timeout 300s

Check `docker stats --no-stream` again -- `load-test` should now be capped.

</details>

Once `load-test` is running with both a CPU and memory limit set, click **Check**.
