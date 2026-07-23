TITLE="Harden the SSH Daemon"
CATEGORY="security"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="A security review flagged this host's default SSH config:
root can log in directly, and password authentication is enabled — both
common brute-force targets."
OBJECTIVE="Edit /etc/ssh/sshd_config so that:
  1. PermitRootLogin is set to 'no'
  2. PasswordAuthentication is set to 'no'
Validate your syntax with 'sudo sshd -t' before finishing (it should
produce no output on success).
Run 'lab check 03-security/003-ssh-hardening' when done."
