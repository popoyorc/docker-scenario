## Alert 1: "orders-service deploy just went out. Health checks are already failing."

Someone just deployed `orders-service` and it's already being flagged as unhealthy. Start
investigating.

Run this to (re)create the situation:

    docker run -d --name orders-service orders-service-image

Now check on it:

    docker ps

Notice anything strange?

<details>
<summary>Hint 1</summary>

`docker ps` only shows containers that are **currently running**. Is there a way to see
containers that already stopped, so you can find out what happened to this one?

</details>

<details>
<summary>Hint 2</summary>

You've used a flag before to see "all" containers, not just the running ones. Once you find the
stopped container, how do you see what it printed to the screen before it stopped?

</details>

<details>
<summary>Hint 3</summary>

Try:

    docker ps -a
    docker logs orders-service

Read the error. It's complaining about a missing environment variable. Fix it by removing the
broken container and starting it again, this time providing what it needs:

    docker rm orders-service
    docker run -d --name orders-service -e PORT=5000 orders-service-image

</details>

Once `docker ps` shows `orders-service` as **Up**, click **Check**.
