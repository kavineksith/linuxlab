TITLE="Move an AppArmor Profile to Enforce Mode"
CATEGORY="security-mac"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="Ubuntu and Debian ship with AppArmor, a Mandatory Access
Control (MAC) system that confines what individual programs can do,
even if they're compromised or misbehaving. (RHEL/CentOS/Fedora use
SELinux for the same purpose — different tool, same idea: MAC beyond
plain file permissions.) A profile on this box is loaded but only in
'complain' mode (logs violations, doesn't block them) — it needs to
actually enforce."
OBJECTIVE="1. Confirm AppArmor is enabled (aa-status / apparmor_status).
2. Find the profile for /usr/sbin/labguard (installed for you) — it
   should currently show as in 'complain' mode.
3. Switch it to 'enforce' mode using aa-enforce.
4. Confirm aa-status now lists it under enforced profiles, not complain.
Run 'lab check 08-security-mac/001-apparmor-status' when done."
