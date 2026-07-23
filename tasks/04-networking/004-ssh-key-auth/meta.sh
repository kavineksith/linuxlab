TITLE="Set Up Passwordless SSH Key Auth"
CATEGORY="networking"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A CI pipeline needs to SSH into this box without a
password prompt. That means generating a keypair and authorizing it —
and getting the file permissions exactly right, since sshd silently
refuses to use keys protected by overly-permissive files."
OBJECTIVE="1. Generate an ed25519 SSH keypair at ~/.ssh/id_ed25519 with
   no passphrase.
2. Add the public key to ~/.ssh/authorized_keys.
3. Set correct permissions: ~/.ssh directory must be 700, and
   ~/.ssh/authorized_keys must be 600.
Run 'lab check 04-networking/004-ssh-key-auth' when done."
