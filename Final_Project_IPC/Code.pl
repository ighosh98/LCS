
/* Rule 100*/
private_defence(X) :- list(Ls), (member(cause_harm(X),Ls);member(cause_rape(X),Ls);
						member(assault_unnatural_Lust(X),Ls);
						member(assault_kidnapping(X),Ls);
						member(assault_for_wrongfully_confining_a_person(X),Ls);
						member(acid_attack(X),Ls)).
						
						
/*Rule 120A,120B*/
conspiracy(X):- list(Ls), member(illegal_act(X),Ls),
				member(punishable_with_imprisonment(X),Ls)
				,write('Rule 120A and 120B is applicable').


/*Rule 103*/
private_defence_of_properties(X):- list(Ls),
								private_defence(X),
								member(robbery(X),Ls),
								member(house_breaking_night(X),Ls),
								member(mischief_by_fire(X),Ls), 
								(member(theft(X),Ls);member(mischief(X),Ls);
								member(apprehension_of_harm(X),Ls)).
/*Rule 103*/
private_defence_of_property_death(X):- list(Ls), member(death_offences(X),Ls),private_defence_of_properties(X)
										,write('Rule 103 is applicable').
/*Rule 105 Commencement and continuance of the right of private defence of property.*/

private_defence_of_property(X) :- private_defence_of_properties(X),
									write('Rule 105 is applicable').

/*Rule 106 Right of private defence against deadly assault when there is risk of harm to innocent person.*/

private_defence_against_deadly_assault(X) :- list(Ls),(member(apprehension_of_harm(X),Ls),
											member(risk_of_harm_to_innocent_person(X),Ls))
											,write('Rule 106 is applicable').
private_defence_of_body(X) :- list(Ls),member(death_offences(X),Ls),private_defence(X)
							,write('Rule 100 is applicable').
/*Rule 101  Commencement and continuance of the right of private defence of the body.*/

private_defence_of_body(X) :- list(Ls),member(death_offences(X),Ls),private_defence(X)
							,write('Rule 102 is applicable').
/*Rule 102 When the right of private defence of property extends to causing death.*/

private_defence_of_body(X) :- list(Ls), 
							member(attempt_of_offence(X),Ls),
							member(continues_as_long_as_apprehension_to_body_continues(X),Ls),
							write('Rule 102 is applicable').
/*Rule 104 When such right extends to causing any harm other than death.*/

private_defence_of_body(X) :- list(Ls),(member(death_offences(X),Ls)),(private_defence_of_properties(X))
							,write('Rule 104 is applicable').

/*Rule 141 and 143*/


unlawful_assembly(X):- list(Ls),member(more_than_five_people(X),Ls),member(criminal_force(X),Ls),
					(member(govt(X),Ls);member(public_servant(X),Ls))
					,write('Rule 141 and 143 are applicable').

/*Rule 142*/
member_of_unlawful_assembly(X):- list(Ls),unlawful_assembly(X),member(intentional_joining_unlawful_assembly(X),Ls)
								,write('Rule 142 is applicable').



/*Rule 144*/
go_armed_unlawful(X):- list(Ls),(unlawful_assembly(X)),member(deadly_weapon(X),Ls)
						,write('Rule 144 is applicable').

/*Rule 145*/
punishment_joining_unlawful(X):- list(Ls),unlawful_assembly(X),
								member(continue_unlawful_assembly(X),Ls)
								,write('Rule 145 is applicable').


/*Rule 146*/
riot(X):- list(Ls),unlawful_assembly(X),member(force_used(X),Ls)
			,write('Rule 146 and 148 are applicable').

/*Rule 148*/
go_armed_riot(X):- list(Ls),riot(X),member(deadly_weapon(X),Ls)
				,write('Rule 148 is applicable').
/*Rule 108*/
abettor(X):- list(Ls),
			(member(abets_offence(X),Ls);member(abets_commision_of_offence(X),Ls))
			,write('Rule 108 is applicable').
/*Rule 107*/
abetment(X,Y) :- list(Ls),(member(instigator(X),Ls);
						member(engage_in_conspiracy(X),Ls);member(aids(Y),Ls))
						,write('Rule 107 is applicable').

/*Rule 112 and 113*/

liable_for(X):- list(Ls), abetment(X,other),
				member(different_act_done(X),Ls),
				write('Rule 112 and 113 are applicable').

/*Rule 90*/

consent(X) :- list(Ls),((member(consent_given(X),Ls),member(child_less_than_twelve(X,age))); 
				(member(consent_given(X),Ls),member(insane_person(X),Ls));
				(member(consent_given(X),Ls),(member(fear_of_injury(X),Ls);
				member(misconception_fact(X),Ls))))
				,write('Rule 87 is applicable').



/*Rules for chapter 4: Exceptions(Chapter-4) Rule 76*/
guilty(X) :- list(Ls),(member(bound(X),Ls); 
			(member(mistake_of_fact(X),Ls),
			member(not_mistake_of_law(X),Ls),
			member(good_faith(X),Ls))),write('Rule 76 is applicable').
			
/*Rule 77*/			
guilty(X) :- list(Ls),( 
			member(judge(X),Ls), 
			member(by_law(X),Ls), 
			member(believes_to_be_acting(X),Ls))
			,write('Rule 77 is applicable').

/*Rule 130*/

guilty(X):- list(Ls), (member(aiding_escape_prisoner(X),Ls);member(rescue_prisoner(X),Ls);
			member(harbouring_prisoner(X),Ls)),write('Rule 130 is applicable').
			
			

/*Rule 83*/
guilty(X):- list(Ls), member(child_more_than_seven_less_than_twelve(X),Ls)
				, member(immature_understanding(X),Ls)
				,write('Rule 83 is applicable').
/*Rule 159 160 Defines affray*/
guilty(X):- list(Ls),(member(multiple_persons(X),Ls),
			(member(fighting_in_public(X),Ls);
			member(disturb_peace(X),Ls))),write('Rule 159 and 160 are applicable').

/*Rule 80*/
guilty(X):- list(Ls),( member(done_by_accident(X),Ls), 
			(member(without_criminal_intention(X),Ls); 
			member(lawful_act(X),Ls)))
			,write('Rule 80 is applicable').			
			
/*Rule 78*/
guilty(X):- list(Ls),( member(done_in_pursuant_to_judgement_of_Court(X),Ls); 
			member(done_in_pursuant_to_or_order_of_Court(X),Ls))
			,write('Rule 78 is applicable').
			
/*Rule 79*/
guilty(X):- list(Ls),( member(justified_act(X),Ls); 
			(member(good_faith(X),Ls), 
			member(mistake_of_fact(X),Ls), 
			(member(mistake_of_law(X),Ls))))
			,write('Rule 79 is applicable').

/*Rule 108*/
guilty(X):- abettor(X),write('Rule 108 is applicable').

/*Rule 137*/
guilty(X) :- list(Ls), member(harbouring_deserter_by_negligence(X),Ls),
				write('Rule 137 is applicable').
/*Rule 81*/
guilty(X):- list(Ls),( member(cause_harm(X),Ls), 
			member(without_criminal_intention(X),Ls), 
			member(prevent_other_harm(X),Ls))
			,write('Rule 81 is applicable').		
/*Rule 82*/
guilty(X):- list(Ls),( member(child_less_than_seven(X),Ls))
			,write('Rule 82 is applicable').
/*Rule 84*/
guilty(X):- list(Ls),( member(unsound_mind(X),Ls)),write('Rule 84 is applicable').
/*Rule 85*/
guilty(X):- list(Ls), (member(incapable_of_judgement(X),Ls),
			member(intoxication_against_will(X),Ls))
			,write('Rule 85 is applicable').
/*Rule 86*/
guilty(X):- list(Ls),( member(not_intended_cause_of_death_hurt(X),Ls), 
			member(not_known_cause_of_death_hurt(X),Ls),consent(X))
			,write('Rule 86 is applicable').
/*Rule 87,88  Offence requiring a particular intent or knowledge committed by one who is intoxicated.*/

guilty(X):- list(Ls),(member(not_intended_cause_of_death_hurt(X),Ls), 
			member(consent_given(X),Ls)),write('Rule 87 and 88 are applicable').

/*Rule 89*/
guilty(X):- list(Ls),( member(not_intended_cause_of_death(X),Ls),
			member(consent_given(X),Ls),member(good_faith(X),Ls),member(for_persons_benefit(X),Ls)),
			(member(child_or_insane_person_benefit(X),Ls);member(insane_person_benefit(X),Ls))
			,write('Rule 89 is applicable').


/*Rule 92*/
guilty(X):- list(Ls), (member(good_faith(X),Ls),
			member(benefit_of_person(X),Ls),consent(X),
			(member(prevent_death(X),Ls);member(prevent_injury(X),Ls)))
			,write('Rule 92 is applicable').

/*Rule 93*/
guilty(X):- list(Ls),( member(good_faith(X),Ls),member(communication_made(X),Ls))
			,write('Rule 93 is applicable').

/*Rule 94*/
guilty(X):- list(Ls),( member(under_threat(X),Ls), 
			(member(murder(X),Ls),member(death_offences(X),Ls)),
			( member(on_accord(X),Ls);
			member(apprehension_of_harm(X),Ls)))
			,write('Rule 87 is applicable').

/*Rule 95*/
guilty(X):- list(Ls),(member(slight_harm(X),Ls)),write('Rule 95 is applicable').
/*Rule 96*/

guilty(X):- private_defence(X)
			,write('Rule 96 is applicable').


/*Rule 97*/
guilty(X):- (private_defence_of_body(X); 
			private_defence_of_property_death(X))
			,write('Rule 97 is applicable').

/*Rule 98*/
guilty(X):- list(Ls),( member(private_defence_against_insane_person(X),Ls))
			,write('Rule 98 is applicable').
guilty(X):- (private_defence_against_deadly_assault(X))
			,write('Rule 99 is applicable').


/*Rule 91*/
guilty(X):- list(Ls),member(offence_independently_of_harm(X),Ls), 
			(consent(X); member(consent_guardian(X),Ls)),write('Rule 91 is applicable').



/*Rule 99 */
guilty(X) :-(list(Ls), 
			member(does_not_cause_apprehension_of_death(X),Ls), 
			(member(done_by_public_servant(X),Ls);
			member(ordered_by_public_servant(X),Ls);
			member(can_get_protection(X),Ls))
			,member(good_faith(X),Ls),
			write('Rule 99 is applicable')).





/*Rule 109*/
guilty(X):- list(Ls),abetment(X,other),member(no_express_provision(X),Ls)
			,write('Rule 109 is applicable').
/*Rule 110*/
guilty(X):- list(Ls),member(different_intention_from_abettor(X),Ls)
			,write('Rule 110 is applicable').

/*Rule 111*/

guilty(X):- list(Ls),abetment(X,other),
			member(different_act(other),Ls), 
			write('Rule 111 is applicable').
/*Rule 114*/

guilty(X):- list(Ls), abettor(X,other),member(present(X),Ls),
			write('Rule 114 is applicable').

/*Rule 115*/

guilty(X):- list(Ls), abetment(X,other),
			member(death_or_life_imprisonment(X),Ls),
			write('Rule 115 is applicable').
/*Rule 116*/
guilty(X):- list(Ls), abetment(X,other),(
			member(public_servant(X),Ls), 
			member(duty_to_prevent(other),Ls)),write('Rule 116 is applicable').

/*Rule 117*/
guilty(X) :- list(Ls), abettor(X),member(committed_by(public),Ls)
			,write('Rule 117 is applicable').
/*Rule 118*/

guilty(X):- list(Ls), member(concealing_design(X),Ls),
			member(death_or_life_imprisonment(other),Ls)
			,write('Rule 118 is applicable').

/*Rule 119*/

guilty(X):- list(Ls),
			member(concealing_design(X),Ls),
			member(public_servant(X),Ls), member(duty_to_prevent(X),Ls)
			,write('Rule 119 is applicable').

/*Rule 120*/

guilty(X):- list(Ls), member(concealing_design(X),Ls),
			member(punishable_with_imprisonment(X),Ls)
			,write('Rule 120 is applicable').

guilty(X):- list(Ls), (member(waging_war(X),Ls);
			member(attempting_to_wage_war(X),Ls);
			member(abetting_to_wage_war(X),Ls))
			,write('Rule 121 is applicable').

/*Rule 121A*/

guilty(X):- list(Ls), conspiracy(X),
			(member(waging_war(X),Ls);
			member(attempting_to_wage_war(X),Ls);
			member(abetting_to_wage_war(X),Ls))
			,write('Rule 121A is applicable').

/*Rule 122*/

guilty(X):- list(Ls), member(collect_arms_for_war(X),Ls)
			,write('Rule 122 is applicable').

/*Rule 123*/

guilty(X):- list(Ls), member(conceal_arms_to_wage_a_war(X),Ls)
			,write('Rule 123 is applicable').

/*Rule 124*/

guilty(X):- list(Ls), (member(assault_governer(X),Ls);member(assault_president(X),Ls))
			,write('Rule 124A is applicable').

		
/*Rule 124A*/

guilty(X):- list(Ls), member(sedition(X),Ls),write('Rule 124A is applicable').

/*Rule 125*/

guilty(X):- list(Ls),(member(waging_war_against_asiatic_alliance(X),Ls)),
			write('Rule 125 is applicable').

/*Rule 126*/
guilty(X):- list(Ls), member(depredation_territories_of_power(X),Ls),
			write('Rule 126 is applicable').


/*Rule 127*/
guilty(X):- list(Ls), member(retrieving_property_by_war_depredation(X),Ls)
			,write('Rule 127 is applicable').

/*Rule 128,129*/

guilty(X):- list(Ls), (member(servant_of_government(X),Ls),
			(member(allow_voluntarily_escape(X),Ls);member(negligence_escape(X),Ls)))
			,write('Rule 128 and 129 is applicable').




/*Chapter 7, Beginning with Rule 131*/



guilty(X):- list(Ls),(abetment(X,mutiny);(member(attempt_to_seduce_from_duty(X),Ls),
			(member(public_servant(soldier),Ls);
			member(public_servant(sailor),Ls);
			member(public_servant(airman),Ls)))),write('Rule 131 is applicable').

/*Rule 132*/
guilty(X):- abetment(X,mutiny),write('Rule 132 is applicable').

/*Rule 133,134*/

guilty(X):- abetment(X,assault),(abettor(soldier);
			abettor(airman);abettor(sailor))
			,write('Rule 133 is applicable').
guilty(X):- abetment(X,assault),write('Rule 134 is applicable').

/*Rule 135*/
guilty(X):- list(Ls), abetment(X,desertion),
			(member(public_servant(soldier),Ls);
			member(public_servant(sailor),Ls);
			member(public_servant(airman),Ls))
			,write('Rule 135 is applicable').

/*Rule 136*/
guilty(X):- list(Ls), member(harbouring_deserter(X),Ls),
			write('Rule 136 is applicable').

/*Rule 138*/
guilty(X):- list(Ls),abetment(X,subordination),
			(member(public_servant(soldier),Ls);
			member(public_servant(sailor),Ls);
			member(public_servant(airman),Ls))
			,write('Rule 138 is applicable').

/*Rule 139,140*/

guilty(X):- list(Ls),( member(wear_garb(X),Ls);
			member(carry_tokens_used_by_sailor_servant_airman(X),Ls)),
			write('Rule 139 and 140 is applicable').

/*Rule 148*/
guilty(X):- list(Ls),riot(X),member(deadly_weapon(X),Ls),write('Rule 148 is applicable').

/*Rule 149*/
guilty(X):- list(Ls),member_of_unlawful_assembly(X),
			member(offence_commited_in_prosecution_of_common_object(X),Ls)
			,write('Rule 149 is applicable').

/*Rule 150 hiring, engagement or employment of any person to
join or become a member of any unlawful assembly*/
guilty(X):- list(Ls),member(hiring_for_unlawful_asssembly(X),Ls),
			write('Rule 99 is applicable').

/*unlawful assembly Rule 151*/
guilty(X):- list(Ls),member(more_than_five_people(X),Ls),
			(member(criminal_force(X),Ls),member(govt(X),Ls);member(public_servant(X),Ls)),
			write('Rule 151 is applicable').
			
/*Rule 152*/
guilty(X):- list(Ls),( member(assault_public_servant_suppressing_riot(X),Ls);
			member(obstruct_public_servant_suppressing_riot(X),Ls)),
			write('Rule 152 is applicable').	
/*Rule 153*/
guilty(X) :- list(Ls),member(provoke_riot(X),Ls),(member(knowingly_carrying_arms(X),Ls); 
			member(attends_mass_drill(X),Ls);member(attends_mass_training(X),Ls)),member(violating_public_notice(X),Ls)
			,write('Rule 153 is applicable').	
/*Rule 154 Owner or occupier of land on which an unlawful assembly is held.*/

guilty(X):- (list(Ls),member(owner(X),Ls);member(occupier(X),Ls)),
			unlawful_assembly(X),
			member(knowledge(X),Ls),
			member(reason_to_believe(X),Ls),
			member(not_give_notice(X),Ls),
			member(use_lawful_powers_to_prevent_it(X),Ls),
			write('Rule 154 is applicable').

/*Rule 155  Liability of person for whose benefit riot is committed.*/			
			
guilty(X):- (list(Ls), member(owner(X),Ls);member(occupier(X),Ls)),
			riot(X),
			member(knowledge(X),Ls),
			member(reason_to_believe(X),Ls),
			member(use_lawful_powers_to_prevent_it(X),Ls),
			write('Rule 155 is applicable').
	
/*Rule 156  Liablility of agent of owner or occupier for whose benefit riot is committed.*/
guilty(X):- (list(Ls), member(owner(X),Ls);member(occupier(X),Ls)),
			riot(X),
			member(knowledge(X),Ls),
			member(not_give_notice(X),Ls),
			member(reason_to_believe(X),Ls),
			member(use_lawful_powers_to_prevent_it(X),Ls)
			,write('Rule 99 is applicable').
/*Rule 157 Harbouring persons hired for an unlawful assembly.*/
guilty(X):- (member(harbour(X),Ls);member(receives(X),Ls);member(assembles(X),Ls)),
			list(Ls), member(people_part_of_unlawful_assembly(X),Ls),member(knowledge(X),Ls)
			,write('Rule 99 is applicable').
/*Rule 158 Being hired to take part in an unlawful assembly or riot; or to go armed.*/
			
guilty(X):- list(Ls),(member(hired(X),Ls);
			member(engaged(X),Ls);
			member(assist_riot(X),Ls);
			(member(go_armed_riot(X),Ls),member(causing_death(X),Ls)),
			riot(X)),write('Rule 158 is applicable').





