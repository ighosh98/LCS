% Packet 1 accepted.
packet(1,  ['A', 500, arp, 	'172.17.2.11', '172.17.2.12',	 2, 	tcp, 	80, 	80]).

% Packet 2 dropped - UDP source port 90 and destination port 69 is configured to be dropped.
% Also, ICMP type 3 and message code 9 is configured to be dropped (However, this is preceeded by previous condition during evaluation)
packet(2,  ['D', 890, atalk,'172.17.2.19', '45.23.12.45',	 1, 	udp, 	90,		69,	 3, 9]).

% Packet 3 accepted.
packet(3,  ['F', 700, ipx, 	'172.17.2.19', '172.17.2.13',	 34, 	tcp,	90,		80]).

% Packet 4 accepted.
packet(4,  ['E', 700, xns, 	'172.17.2.18', '172.56.23.11',	 7, 	tcp, 	1000,   80]).

% Packet 5 accepted.
packet(5,  ['G', 459, aarp, '172.17.2.11', '123.45.45.12',	 2,		tcp, 	80,	    80]).

% Packet 6 rejected - mpls  ethernet protocol is configured to be rejected.
packet(6,  ['D', 700, mpls, '172.17.2.15', '10.10.1.3',		 9,	    tcp,	8080,   80]).

% Packet 7 rejected - netbui ethernet protocol is configured to be rejected.
packet(7,  ['P', 700, netbui, '172.17.2.19', '23.45.45.23',	 3,     tcp, 	90,		80]).

% Packet 8 dropped - UDP source port 90 and destination port 69 is configured to be dropped.
% Also, ICMP type 3 and message code 9 is configured to be dropped (However, this
% is preceeded by previous condition during evaluation).
packet(8,  ['B', 269, arp, 	'172.17.2.19', '45.23.12.45',	 1, 	udp, 	90,		69,	 3, 9]).

% Packet 9 rejected - Adapter ID 'L' is configured to be rejected.
packet(9,  ['L', 700, rarp, '172.17.2.11', '10.23.12.45',	 2,     tcp, 	80,		80]).

% Packet 10 accepted.
packet(10, ['C', 459, aarp, '172.17.2.15', '34.23.67.78',	 9,     tcp, 	8080,	80]).

% Packet 11 dropped - Destination IPv4 address 19.23.12.45 is configured to be
% dropped. Also, TCP source port 99 is configured to be dropped (However, this
% is preceeded by previous condition during evaluation).
packet(11, ['H', 500, ipx, 	'172.17.2.19', '19.23.12.45',	 3,     tcp, 	99,	    80]).

