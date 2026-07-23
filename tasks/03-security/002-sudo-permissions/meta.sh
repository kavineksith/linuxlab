TITLE="Grant Least-Privilege Sudo Access"
CATEGORY="security"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="The 'deploy' user needs to restart the nginx service without a
password, for use in an automated deploy script. They should NOT get
full, unrestricted sudo access — only permission to run that one
systemctl command."
OBJECTIVE="Create a sudoers drop-in file at /etc/sudoers.d/deploy-nginx
that allows the 'deploy' user to run exactly:
  systemctl restart nginx
with NOPASSWD, and nothing broader. Use visudo -c or visudo -cf to
validate syntax before finishing.
Run 'lab check 03-security/002-sudo-permissions' when done."
