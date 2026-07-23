TITLE="Patch the Config with sed"
CATEGORY="fundamentals"
DIFFICULTY="beginner"
ENVIRON="both"
DESCRIPTION="A config file named server.conf shipped with placeholder
values. You need to update it in place using a stream editor rather than
opening it in a text editor by hand — good practice for scripting
deployments."
OBJECTIVE="Edit server.conf in the workspace directory so that:
  1. The line 'debug=true' becomes 'debug=false'
  2. The line 'port=8000' becomes 'port=8443'
Use sed (not manual editing) so the technique generalizes to automation.
Run 'lab check 01-fundamentals/004-text-processing' when done."
