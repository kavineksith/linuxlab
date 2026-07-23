TITLE="Audit Access to a Sensitive File"
CATEGORY="security-mac"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="Compliance wants proof of every write to the master
credentials file, /etc/lab/secrets.conf. auditd (the Linux Audit
Daemon — the same subsystem RHEL/CentOS lean on heavily for compliance
like PCI-DSS and STIG) can watch specific files and log every access."
OBJECTIVE="1. Add an audit rule watching /etc/lab/secrets.conf for
   write and attribute-change access (permissions 'wa'), tagged with
   the key 'lab-secrets-watch'.
2. Trigger it by writing to the file (e.g. echo test | sudo tee -a
   /etc/lab/secrets.conf).
3. Confirm the event shows up via 'ausearch -k lab-secrets-watch'.
Run 'lab check 08-security-mac/003-audit-watch' when done."
