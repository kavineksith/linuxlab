TITLE="Connect Two Containers on a Private Network"
CATEGORY="containers"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="A frontend container needs to talk to a backend container
by name, the way services do in real docker-compose/Kubernetes setups —
not by hardcoded IP addresses. That requires a user-defined network,
which gives you automatic DNS between containers."
OBJECTIVE="Using docker OR podman:
  1. Create a user-defined bridge network named 'labnet'.
  2. Run a container named 'labdb' (image: alpine:latest, keep it
     alive with a long-running command like 'sleep infinity') attached
     to labnet.
  3. Run a second container named 'labapi' (also alpine:latest, also
     sleep infinity) attached to labnet.
  4. From inside labapi, successfully ping labdb BY NAME (not by IP) —
     this only works because both are on the same user-defined network.
Run 'lab check 10-containers/003-container-networking' when done."
