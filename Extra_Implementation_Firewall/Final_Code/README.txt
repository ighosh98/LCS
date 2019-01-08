Inputs
The input is defined in a predicate packet, whose arguments are:
1. Packet ID: Integer (Used to identify a packet)
2. A list defining the actual packet

Each packet is defined as a list of values (in order):
1. Adapter (Any character between 'A' and 'P', both inclusive).
2. Ethernet vlan id (Any integer between 1 to 999).
3. Ethernet protocol alias (Any one of arp, aarp, atalk, ipx, mpls, netbui, pppoe, rarp, sna, xns). 
4. IPv4 source address (of the form 'xxx.xxx.xxx.xxx', where xxx is any integer between 0 to 255.).
5. IPv4 destination address (of the form 'xxx.xxx.xxx.xxx', where xxx is any integer between 0 to 255.).
6. IPv4 protocol ID (decimal value which specifies the protocol to which the packet belongs).
7. IPv4 protocol type (either of tcp or udp(atoms)).
8. Source port number (an integer between 1 to 65535).
9. Destination port number (an integer between 1 to 65535).
10. ICMP code (decimal value specifying the type of ICMP packet)
11. ICMP message (decimal value referring to the message carried by the ICMP packet).
12. Packet contains ICMP code and msg only when ipv4 protocol id is 1 (which denotes that ipv4 datagram is ICMP type)

Example:

packet(2, ['D', 890, atalk,'172.17.2.19', '45.23.12.45', 1, udp, 90,	69,	3, 9]).
