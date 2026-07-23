FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    curl \
    vim \
    git

COPY . /app
WORKDIR /app

RUN pip3 install flask

CMD ["python3", "app.py"]
