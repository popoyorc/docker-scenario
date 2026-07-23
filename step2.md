## Step 2 -- Real World: Legacy & Modern, Side by Side

**MegaCorp problem:** An old internal tool was built years ago on Python 2. Nobody wants to
touch it or rewrite it, but it still needs to run right next to brand-new services built on
Python 3 -- on the very same server -- without either one breaking the other.

Without containers, installing both Python 2 and Python 3 system-wide on one machine is a
nightmare of conflicting paths, libraries, and versions. Watch how Docker makes it trivial.

Run the "legacy" service:

    docker run -d --name legacy-service -p 8081:8000 python:2.7-slim python -m SimpleHTTPServer 8000

Run the "modern" service, right next to it:

    docker run -d --name modern-service -p 8082:8000 python:3.12-slim python -m http.server 8000

Check both are alive at the same time:

    docker ps
    curl -I localhost:8081
    curl -I localhost:8082

Two completely different, normally-incompatible runtimes, running simultaneously on one host,
with zero conflicts. This is exactly how MegaCorp keeps decade-old internal tools alive
alongside cutting-edge services -- each container brings its **own** self-contained runtime, so
nothing on the host ever has to match.

**Click Check when both services are confirmed running.**
