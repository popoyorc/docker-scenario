## Alert 4: "We redeployed to fix a config, and now all the order history is gone."

Simulate the "data" `orders-service` writes while it runs:

    docker exec orders-service sh -c "echo 'order #1234' > /app/orders.log"
    docker exec orders-service cat /app/orders.log

Now simulate a redeploy (removing and recreating the container, like a real deployment would):

    docker rm -f orders-service
    docker run -d --name orders-service --network megacorp-net -e PORT=5000 orders-service-image

Check the log again:

    docker exec orders-service cat /app/orders.log

Gone. Where did it go, and how do we stop this from happening again?

<details>
<summary>Hint 1</summary>

When you remove a container, what happens to the files that were created *inside* it?

</details>

<details>
<summary>Hint 2</summary>

You've learned a way to make a folder "live outside" the container, so it survives even if the
container is deleted and recreated. It's a flag on `docker run`.

</details>

<details>
<summary>Hint 3</summary>

Use a volume so the data lives outside the container:

    docker rm -f orders-service
    docker volume create orders-data
    docker run -d --name orders-service --network megacorp-net -e PORT=5000 \
      -v orders-data:/app/data orders-service-image
    docker exec orders-service sh -c "echo 'order #1234' > /app/data/orders.log"

Now try removing and recreating the container again -- the file in `/app/data/orders.log`
should survive this time.

</details>

Once `orders.log` survives a container removal + recreation, click **Check**.
