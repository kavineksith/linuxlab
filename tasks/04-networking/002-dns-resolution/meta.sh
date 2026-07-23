TITLE="Add a Local DNS Override"
CATEGORY="networking"
DIFFICULTY="beginner"
ENVIRON="both"
DESCRIPTION="A developer needs 'lab.internal' to resolve to this
machine itself for local testing, without touching any real DNS
infrastructure."
OBJECTIVE="Add an entry to /etc/hosts mapping the hostname 'lab.internal'
to 127.0.0.1, and confirm it resolves with 'getent hosts lab.internal'.
Run 'lab check 04-networking/002-dns-resolution' when done."
