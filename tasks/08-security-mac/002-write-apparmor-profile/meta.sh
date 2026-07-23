TITLE="Write an AppArmor Profile from Scratch"
CATEGORY="security-mac"
DIFFICULTY="advanced"
ENVIRON="native"
DESCRIPTION="A new internal script, /usr/local/bin/labreader, only ever
needs to read files under /var/lab/data/. Ops wants a MAC profile that
enforces exactly that — so even if the script had a bug or was
compromised, it physically could not write anywhere or read outside
that directory."
OBJECTIVE="1. Create an AppArmor profile at
   /etc/apparmor.d/usr.local.bin.labreader for /usr/local/bin/labreader
   that allows only READ access (r) under /var/lab/data/** and nothing
   else beyond the base abstraction.
2. Load it and put it in enforce mode.
3. Confirm with aa-status that it's enforced.
Run 'lab check 08-security-mac/002-write-apparmor-profile' when done."
