TITLE="Build and Tag a Custom Image"
CATEGORY="containers"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="A tiny internal tool needs to ship as a container image
instead of a loose script someone has to remember to install
dependencies for. Run this on your host with docker or podman
installed."
OBJECTIVE="In the workspace directory, write a Dockerfile that:
  1. Uses 'alpine:latest' as its base image.
  2. Copies a file named greet.sh into the image at /usr/local/bin/greet.sh.
  3. Makes it executable and sets it as the container's ENTRYPOINT.
Also create greet.sh (any script that prints a greeting is fine, e.g.
'echo Hello from the lab container').
Build the image tagged 'labapp:1.0', then run a container from it and
confirm it prints your greeting.
Run 'lab check 10-containers/002-build-custom-image' when done."
