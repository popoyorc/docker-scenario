## Alert 3: "Port's open now, but the load balancer is returning 502s."

MegaCorp puts an nginx load balancer in front of every service. It's up, but every request comes
back with a `502 Bad Gateway` -- even though `orders-service` is healthy on its own.

Start the load balancer:

    docker run -d --name lb -p 8080:80 -v ~/assets/nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro nginx:alpine

Test it:

    curl http://localhost:8080

502. Why can the load balancer not reach a container that's clearly running?

<details>
<summary>Hint 1</summary>

Two separate containers don't automatically know about each other, even if both are running on
the same machine. What do you think needs to connect them so one can "find" the other by name?

</details>

<details>
<summary>Hint 2</summary>

You've learned that containers can join a shared network so they can talk to each other by
name. Is there a command to check which network a container currently belongs to, and another
to create a shared one?

</details>

<details>
<summary>Hint 3</summary>

Check what network each container is on:

    docker inspect orders-service --format '{{.NetworkSettings.Networks}}'
    docker inspect lb --format '{{.NetworkSettings.Networks}}'

They're on different (default) networks. Create a shared network and put both containers on it:

    docker network create megacorp-net
    docker rm -f orders-service lb
    docker run -d --name orders-service --network megacorp-net -e PORT=5000 orders-service-image
    docker run -d --name lb --network megacorp-net -p 8080:80 -v ~/assets/nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro nginx:alpine

</details>

Once `curl http://localhost:8080` returns `orders-service is healthy`, click **Check**.
