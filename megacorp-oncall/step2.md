## Alert 2: "Container's running now, but the frontend team says they can't reach it."

`orders-service` shows as running, but nobody outside the container can reach it.

Try it yourself:

    curl http://localhost:5000

Nothing comes back. What's going on?

<details>
<summary>Hint 1</summary>

"Running" and "reachable from outside the container" are two different things. What connects a
port on your machine to a port inside the container?

</details>

<details>
<summary>Hint 2</summary>

Is there something you'd normally add when starting a container so that a port becomes reachable
from the host? Check whether it was included when `orders-service` was started.

</details>

<details>
<summary>Hint 3</summary>

Check how it was started:

    docker inspect orders-service

Look at `NetworkSettings.Ports` -- it's empty, because no `-p` flag was used. Recreate the
container with a port mapping:

    docker rm -f orders-service
    docker run -d --name orders-service -e PORT=5000 -p 5000:5000 orders-service-image

</details>

Once `curl http://localhost:5000` returns `orders-service is healthy`, click **Check**.
