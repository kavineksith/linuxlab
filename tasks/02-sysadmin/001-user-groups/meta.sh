TITLE="Onboard a New Teammate"
CATEGORY="sysadmin"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="A new engineer, 'devuser', needs an account on this box. They
should be able to use sudo for admin tasks, and also need access to the
'developers' group for shared project files."
OBJECTIVE="1. Create a user named 'devuser' with a home directory.
2. Create a group named 'developers' if it doesn't exist.
3. Add 'devuser' to both the 'sudo' group and the 'developers' group.
Run 'lab check 02-sysadmin/001-user-groups' when done.
Note: this task modifies real system users/groups — run it in the
container image or a disposable VM, not your daily machine."
