TITLE="Lock Down the Firewall"
CATEGORY="security"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="This host currently accepts inbound traffic on every port.
Ops wants a default-deny posture: only SSH (22) and the app's port
(8080) should be reachable from outside."
OBJECTIVE="Using ufw:
  1. Set the default incoming policy to deny.
  2. Set the default outgoing policy to allow.
  3. Allow inbound TCP traffic on port 22 (SSH).
  4. Allow inbound TCP traffic on port 8080.
  5. Enable ufw.
Run 'lab check 03-security/004-firewall-ufw' when done."
