import os
from flask import Flask

app = Flask(__name__)

# NOTE: this raises a KeyError and crashes immediately if PORT isn't provided.
PORT = int(os.environ["PORT"])


@app.route("/")
def index():
    return "orders-service is healthy\n"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)
