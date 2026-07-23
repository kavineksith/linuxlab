TITLE="Add a Secondary IP Address"
CATEGORY="networking"
DIFFICULTY="intermediate"
ENVIRON="native"
DESCRIPTION="A legacy internal tool expects to reach this host at
192.168.77.10 in addition to its normal address. Rather than reconfigure
the whole interface, you just need to add a secondary address alias."
OBJECTIVE="Using the 'ip' command, add the address 192.168.77.10/24 to
the loopback interface (lo), and verify it appears in 'ip addr show'.
(Requires NET_ADMIN privileges — run on a native host or a privileged
container.)
Run 'lab check 04-networking/001-ip-addressing' when done."
