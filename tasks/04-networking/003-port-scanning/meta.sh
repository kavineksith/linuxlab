TITLE="Identify the Mystery Listener"
CATEGORY="networking"
DIFFICULTY="intermediate"
ENVIRON="both"
DESCRIPTION="A process on this box has opened a TCP listening socket
somewhere in the 9000-9100 port range. Security wants to know exactly
which port before they decide whether it's expected."
OBJECTIVE="Using ss (or netstat), find the TCP port in the 9000-9100
range that has a process listening on it, and write just the port
number into answer.txt in the workspace root.
Run 'lab check 04-networking/003-port-scanning' when done."
