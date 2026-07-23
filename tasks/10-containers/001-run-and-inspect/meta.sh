TITLE="Run and Inspect Your First Container"
CATEGORY="containers"
DIFFICULTY="beginner"
ENVIRON="native"
DESCRIPTION="Nearly every modern deployment target — cloud, on-prem,
CI/CD — runs on containers. This is run on your HOST machine (with
Docker or Podman installed), not nested inside the linuxlab container
itself. If you're doing linuxlab as a container, do this task on the
host, or in a separate privileged docker-in-docker setup."
OBJECTIVE="Using docker OR podman (same syntax either way):
  1. Run a detached container named 'labweb' from the nginx:alpine
     image, publishing container port 80 to host port 8081.
  2. Confirm it's running with '<tool> ps'.
  3. Confirm the mapped port actually serves something with
     'curl -s localhost:8081' — it should return HTML.
Run 'lab check 10-containers/001-run-and-inspect' when done."
