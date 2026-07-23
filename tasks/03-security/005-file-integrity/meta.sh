TITLE="Spot the Tampered File"
CATEGORY="security"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A release directory ships with a checksums.sha256 manifest
so downstream users can verify nothing was tampered with in transit.
One file in this copy doesn't match its recorded checksum."
OBJECTIVE="In the workspace's release/ directory, use sha256sum to
verify the files against checksums.sha256, identify the ONE file that
fails verification, and write just its filename (e.g. app.bin — no
path, no extra text) into answer.txt in the workspace root.
Run 'lab check 03-security/005-file-integrity' when done."
