:- ensure_loaded('input.pl').
:- use_module('input.pl', [packet/2]).
:- ensure_loaded('database.pl').

:- use_module('database.pl').
:- ensure_loaded('ipv4_helper.pl').
:- use_module('ipv4_helper.pl', [ip_range_compare_str/3]).

rejected(Z, Y) :- nl, write('Packet ID '), write(Z), write(' rejected. '), write('Cause: '), write(Y).
accepted(Z) :- nl, write('Packet ID '), write(Z), write(' accepted.').
dropped(Z) :- nl, write('Packet ID '), write(Z), write(' dropped! ').

	

/* ### ACCEPT PROCEDURE ### */

check_accept(X, Y) :-
	/* Accept Adapter */
	(
		(nth0(0, Y, Ad),
			(
				(accept_adapter_r(AdL, AdH), char_range_compare(AdL, AdH, Ad));
				(accept_adapter_l(L), member(Ad, L));
				accept_adapter(Ad)
			)
		);
			
		/* Accept Ethernet */
		(
			nth0(1, Y, EtVid), nth0(2, Y, EtPr),
			% Checking vor various possible ethernet clauses
			(
				% Checking for accept_ether_vid_r_proto_l
				forall(
					accept_ether_vid_r_proto_l(VlanL, VlanH, VPrL),
					(member(EtPr, VPrL), int_range_compare(VlanL, VlanH, EtVid))
				);
					
				% Checking for accept_ether_vid_proto_l
				forall(accept_ether_vid_proto_l(EtVid, VPL), member(EtPr, VPL));
					
				% Checking for accept_ether_vid_r_proto
				forall(accept_ether_vid_r_proto(VidL, VidH, EtPr), int_range_compare(VidL, VidH, EtVid));
					
				% Checking for accept_ether_vid_proto
				(accept_ether_vid_proto(EtVid, EtPr));
					
				/*
				  Since none of the above clauses have been satisfied,
				  test for combined satisfaction of any one of the 
				  vlan id clauses and any one of the protocol id clauses
				*/
				% Checking for accept_ether_proto_l
				(accept_ether_proto_l(PL), member(EtPr, PL)); 
					
				% Checking for accept_ether_proto
				accept_ether_proto(EtPr);
				
				% Checking for accept_ether_vid_r
				(accept_ether_vid_r(VLow, VHigh), int_range_compare(VLow, VHigh, EtVid));
				
				% Checking for accept_ether_vid
				accept_ether_vid(EtVid)
			)
		);
		
		/* Accept ipv4 datagrams */	
		(
			nth0(3, Y, Src), nth0(4, Y, Dst), nth0(5, Y, Proto), 
			/* And clauses without ranges */ 
			(
				accept_ip_src_addr(Src);
				accept_ip_dst_addr(Dst);
				accept_ip_addr(Src);
				accept_ip_addr(Dst);
				accept_ip_proto(Proto);
				accept_ip_src_dst_addr_proto(Src, Dst, Proto);
					
				/* And clauses with ranges */ 
				forall(accept_ip_src_addr_r(Q,P), ip_range_compare_str(Q, P, Src));
				forall(accept_ip_dst_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
				forall(accept_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Src)); 
				forall(accept_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
				forall(accept_ip_src_dst_addr_proto_r(Q, P, W, V, Z), ip_src_dst_addr_proto_r_check(Q, P, W, V, Z, Src, Dst, Proto))
			)
		 );
		
		/* Accept TCP or UDP ports */
		(
			nth0(6, Y, Proto_tu), nth0(7, Y, Src_port), nth0(8, Y, Dst_port), 
			(
				((Proto_tu == tcp), (accept_tcp_src_port(Src_port); accept_tcp_dst_port(Dst_port); accept_tcp_src_dst_port(Src_port,Dst_port)));
				((Proto_tu == udp), (accept_udp_src_port(Src_port); accept_udp_dst_port(Dst_port); accept_udp_src_dst_port(Src_port,Dst_port)))
			)
					
		);
		
		/* Accept ICMP packets, if ipv4 proto code is 1 */ 
		(	
			nth0(5, Y, Proto), 
			(\+(Proto == 1);
				(nth0(9, Y, Type), nth0(10, Y, Code),
					(
						accept_icmp_type(Type);
						accept_icmp_code(Code);
						accept_icmp_type_code(Type, Code)
					)
				)
			)		
		)
	) ,accepted(X).
	
/* #### REJECT PROCEDURE ### */ 

check_reject(X, Y) :-
	(
		/* reject Adapter */
		(
			nth0(0, Y, Ad),
			(
				(reject_adapter_r(AdL, AdH), char_range_compare(AdL, AdH, Ad));
				(reject_adapter_l(L), member(Ad, L));
				reject_adapter(Ad)
			), Z = 'This adapter not allowed'
		);
		
		/* reject Ethernet */
		(
			nth0(1, Y, EtVid), nth0(2, Y, EtPr),
			% Checking vor various possible ethernet clauses
			(
				% Checking for reject_ether_vid_r_proto_l
			    forall(reject_ether_vid_r_proto_l(VlanL, VlanH, VPrL), (member(EtPr, VPrL), int_range_compare(VlanL, VlanH, EtVid)));
					
				% Checking for reject_ether_vid_proto_l
				(reject_ether_vid_proto_l(EtVid, VPL), member(EtPr, VPL));
					
				% Checking for reject_ether_vid_r_proto
				(reject_ether_vid_r_proto(VidL, VidH, EtPr), int_range_compare(VidL, VidH, EtVid));
					
				% Checking for reject_ether_vid_proto
				(reject_ether_vid_proto(EtVid, EtPr));
					
				/*
				  Since none of the above clauses have been satisfied,
				  test for satisfaction of any one of the vlan id clauses
				  or any one of the protocol id clauses
				*/
				% Checking for reject_ether_proto_l
				(reject_ether_proto_l(PL), member(EtPr, PL)); 
					
				% Checking for reject_ether_proto
				reject_ether_proto(EtPr);
				
				% Checking for reject_ether_vid_r
				(reject_ether_vid_r(VLow, VHigh), int_range_compare(VLow, VHigh, EtVid));
				
				% Checking for reject_ether_vid
				reject_ether_vid(EtVid)
			), Z = 'This ethernet vlan id or protocol is not allowed.'
		);
		/* reject ipv4 datagrams */	
		(
			nth0(3, Y, Src), nth0(4, Y, Dst), nth0(5, Y, Proto), 
			/* And clauses without ranges */ 
	   		(
	       		reject_ip_src_addr(Src);
	       		reject_ip_dst_addr(Dst);
	       		reject_ip_addr(Src);
	       		reject_ip_addr(Dst);
	       		reject_ip_proto(Proto);
	       		reject_ip_src_dst_addr_proto(Src, Dst, Proto);
		   		
		   		/* And clauses with ranges */ 
		   		forall(reject_ip_src_addr_r(Q,P), ip_range_compare_str(Q, P, Src));
		   		forall(reject_ip_dst_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
			   	forall(reject_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Src)); 
			   	forall(reject_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
			   	forall(reject_ip_src_dst_addr_proto_r(Q, P, W, V, Z), ip_src_dst_addr_proto_r_check(Q, P, W, V, Z, Src, Dst, Proto))
		   	), Z = 'This IPv4 source or destination is not allowed.'
		 );
		
		/* reject TCP or UDP ports */
		(
			nth0(6, Y, Proto_tu), nth0(7, Y, Src_port), nth0(8, Y, Dst_port), 
			(
				((Proto_tu == tcp), (reject_tcp_src_port(Src_port); reject_tcp_dst_port(Dst_port); reject_tcp_src_dst_port(Src_port,Dst_port)));
				((Proto_tu == udp), (reject_udp_src_port(Src_port); reject_udp_dst_port(Dst_port); reject_udp_src_dst_port(Src_port,Dst_port)))
			), Z = 'This TCP or UDP port is not allowed.'		
		);
			
		/* reject ICMP packets, if ipv4 proto code is 1 */ 
		(	
			nth0(5, Y, Proto),  
			((Proto == 1),
				(nth0(9, Y, Type), nth0(10, Y, Code),
					(
						reject_icmp_type(Type);
						reject_icmp_code(Code);
						reject_icmp_type_code(Type, Code)					
					)
				)
			), Z = 'This ICMP configuration is not allowed.'
		)
	), rejected(X,Z).
	
/* ### DROP PROCEDURE ### */
	
check_drop(X, Y) :-
	(
		/* drop Adapter */
		(
			nth0(0, Y, Ad),
			(
				(drop_adapter_r(AdL, AdH), char_range_compare(AdL, AdH, Ad));
				(drop_adapter_l(L), member(Ad, L));
				drop_adapter(Ad)
			)
		);
		
		/* drop Ethernet */
		(
			nth0(1, Y, EtVid), nth0(2, Y, EtPr),
			% Checking vor various possible ethernet clauses
			(
				% Checking for drop_ether_vid_r_proto_l
			    forall(drop_ether_vid_r_proto_l(VlanL, VlanH, VPrL), (member(EtPr, VPrL), int_range_compare(VlanL, VlanH, EtVid)));
					
				% Checking for drop_ether_vid_proto_l
				(drop_ether_vid_proto_l(EtVid, VPL), member(EtPr, VPL));
					
				% Checking for drop_ether_vid_r_proto
				(drop_ether_vid_r_proto(VidL, VidH, EtPr), int_range_compare(VidL, VidH, EtVid));
					
				% Checking for drop_ether_vid_proto
				(drop_ether_vid_proto(EtVid, EtPr));
					
				/*
				  Since none of the above clauses have been satisfied,
				  test for combined satisfaction of any one of the 
				  vlan id clauses and any one of the protocol id clauses
				*/
				% Checking for drop_ether_proto_l
				(drop_ether_proto_l(PL), member(EtPr, PL)); 
					
				% Checking for drop_ether_proto
				drop_ether_proto(EtPr);
				
				% Checking for drop_ether_vid_r
				(drop_ether_vid_r(VLow, VHigh), int_range_compare(VLow, VHigh, EtVid));
				
				% Checking for drop_ether_vid
				drop_ether_vid(EtVid)
			)
		);
		/* drop ipv4 datagrams */	
		(
			nth0(3, Y, Src), nth0(4, Y, Dst), nth0(5, Y, Proto), 
			/* And clauses without ranges */ 
	   		(
	       		drop_ip_src_addr(Src);
	       		drop_ip_dst_addr(Dst);
	       		drop_ip_addr(Src);
	       		drop_ip_addr(Dst);
	       		drop_ip_proto(Proto);
	       		drop_ip_src_dst_addr_proto(Src, Dst, Proto);
		   		
		   		/* And clauses with ranges */ 
		   		forall(drop_ip_src_addr_r(Q,P), ip_range_compare_str(Q, P, Src));
		   		forall(drop_ip_dst_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
			   	forall(drop_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Src)); 
			   	forall(drop_ip_addr_r(Q, P), ip_range_compare_str(Q, P, Dst));
			   	forall(drop_ip_src_dst_addr_proto_r(Q, P, W, V, Z), ip_src_dst_addr_proto_r_check(Q, P, W, V, Z, Src, Dst, Proto))
		   	)
		 );
		
		/* drop TCP or UDP ports */
		(
			nth0(6, Y, Proto_tu), nth0(7, Y, Src_port), nth0(8, Y, Dst_port), 
			(
				((Proto_tu == tcp), (drop_tcp_src_port(Src_port); drop_tcp_dst_port(Dst_port); drop_tcp_src_dst_port(Src_port,Dst_port)));
				((Proto_tu == udp), (drop_udp_src_port(Src_port); drop_udp_dst_port(Dst_port); drop_udp_src_dst_port(Src_port,Dst_port)))
			)		
		);
			
		/* drop ICMP packets, if ipv4 proto code is 1 */ 
		(	
			nth0(5, Y, Proto),  
			((Proto == 1),
				(nth0(9, Y, Type), nth0(10, Y, Code),
					(
						drop_icmp_type(Type);
						drop_icmp_code(Code);
						drop_icmp_type_code(Type, Code)					
					)
				)
			)
		)
	), dropped(X).
	
decide(X, Y) :-
		(check_reject(X,Y);
		check_drop(X,Y);
		check_accept(X,Y));
		nl, write(' Packet ID: '), write(X) , write(Y) ,write('fail!').
		%dropped(X, Y).
:- forall(packet(X, Y), decide(X, Y)).