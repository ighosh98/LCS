/*Defining the clauses for the players*/


person(X).
servant_of_government(X).
public(X).
government(X).
india(X).
discontiguous public_servant(x,"officer of military").
child(x,age).
reason_to_believe(X).
good_faith(X).
oath(X).
harbour(X).
servant_of_government(X).
good_faith(X).
guilty(X,Y).
/*Defining abetment( x abets doing of thing y) and abettor*/
abettor(X):-  abets_offence(X);abets_commision_of_offence(X); 
			(person_capable_of_commiting_offence(X)	->	abets_commision_of_act_leading_to_offence(X)).
abettor(X):- offence_commited_in_India(X),abettor(X).
abetment_of_a_thing(x,thing) :- instigate(thing);engage_in_conspiracy(thing);aids(thing).






/*Rules for chapter 4: Exceptions(Chapter-4)*/
believing_himself_to_be_bound(X):-mistake_of_fact(X),(\+(mistake_of_law(X))),good_faith(X).
guilty(X,Y) :- \+(bound(X); believing_himself_to_be_bound(X)).
acting_judicially:- by_law(X), believes_to_be_acting(X).
guilty(X,Y) :- \+(judge(X), acting_judicially(X)).
guilty(X,Y):- \+(done_in_pursuant_to_judgement_of_Court(X); done_in_pursuant_to_or_order_of_Court(X)).
guilty(X,Y):- \+(justified_act(X); (good_faith(X), mistake_of_fact(X), (\+(mistake_of_law(X))))).
guilty(X,Y):- \+(done_by_accident(X), (without_criminal_intention(X); lawful_act(X))).
guilty(X,Y):- \+(cause_harm(X), without_criminal_intention(X), prevent_other_harm(X)).
guilty(X,Y):- \+(child(x,age), (age<7)).
guilty(X,Y):- \+(child(x,age), (age>7), (age<12), immature_understanding(X)).
guilty(X,Y):- \+(unsound_mind(X)).
guilty(X,Y):- \+(incapable_of_judgement(X),intoxication_against_will(X)).
section87(X,Y):- \+(not_intended_cause_of_death_hurt(X),not_known_cause_of_death_hurt(X),consent(X)).
section88(X,Y):- \+(not_intended_cause_of_death(X),consent(X),good_faith(X),for_persons_benefit(X)).
/*Check!*/
provisions(X,Y):- (\+(intentional_death(X)) ; attempting_death(X)) ; grevious_hurt(X) ; abetment(X).
provisions(X,Y):- \+(consent_guardian(X),good_faith(X),
				(child_benefit(X); insane_person_benefit(X)),
				provisions(X)).
guilty(X,Y):- \+(section87(X),section88(X),section89(X)).
consent(X,Y) :- \+((consent(X),child(X,age),age<12); 
				(consent(X),insane_person(X));
				(consent(X),(fear_of_injury(X);misconception_fact(X)))).
/*section 91:Check predicate*/
guilty(X,Y):- offence_independently_of_harm(X), (consent(X); consent_guardian(X)).

guilty(X,Y):- \+(good_faith(X),benefit_of_person(X),(consent(X);\+consent(X)),(prevent_death(X);prevent_injury(X))).
provisions1(X,Y):- causing_death(X); \+(voluntary_hurt(X),\+causing_death(X)).
guilty(X,Y) :- provisions1(X).

guilty(X,Y):- \+(good_faith(X),communication_made(X)).
/*Review Clause 94*/
guilty(X,Y):- \+(under_threat(X), \+(murder(X),death_offences(X)),\+( on_accord(X);apprehension_of_harm(X))).
guilty(X,Y):- \+(slight_harm(X)).
guilty(X,Y):- \+(private_defence(X)).
guilty(X,Y):- \+(private_defence_of_body(X); private_defence_of_property(X)).
guilty(X,Y):- \+(private_defence_against_insane_person(X)).
/*Law 99 in chapter 4
\+private_defence(X) :-.
Review Clause 100*/
private_defencex(X,Y) :- (cause_harm(X);cause_rape(X);
						assault_unnatural_Lust(X);
						assault_kidnapping(X);
						assault_for_wrongfully_confing_a_person(X);
						acid_attack(X)).
private_defence_of_body(X) :- death_offences(X),private_defencex(X).
private_defence_of_body(X) :- \+death_offences(X),\+private_defencex(X).
private_defence_of_body(X) :- attempt_of_offence(X),continues_as_long_as_apprehension_to_body_continues(X).
private_defence_of_propertyx(X):- private_defencex(X),
								robbery(X),
								house_breaking_night(X),
								mischief_by_fire(X), 
								(theft(X);mischief(X);house_tresspass(X))->(apprehension_of_harm(X)).
private_defence_of_property(X):- death_offences(X),private_defence_of_propertyx(X).
private_defence_of_body(X) :- \+death_offences(X),\+private_defence_of_propertyx(X).
private_defence_of_property(X) :- (private_defence_of_propertyx(X)->(true);false).
private_defence_against_deadly_assault(X) :- (apprehension_of_harm(X),risk_of_harm_to_innocent_person(X)->true;false).
/*apprehension nof harm take as superset of apprehension of death*/
guilty(X,Y):- \+(private_defence_against_deadly_assault(X)).


/*encoding chapter 5*/
guilty(X,Y):-abetment(x,thing),\+abetment_all(x,thing).

/*abetment_all covers all the possible abetments mentioned in this section. 
Encoding rules 154-160 Chapter-6
*/
unlawful_assembly(X):- more_than_five_people(X),(criminal_force(X),govt(X);public_servant(X)).
member_of_unlawful_assembly(X):- unlawful_assembly(X),intentional_joining_unlawful_assembly(X).
punishment_unlawful(X):- unlawful_assembly(X).
go_armed_unlawful(X):- (unlawful_assembly(X)),deadly_weapon(X).
punishment_joining_unlawful(X):-unlawful_assembly(X),continue_unlawful_assembly(X).
go_armed_unlawful(X):- (unlawful_assembly(X)),deadly_weapon(X).
riot(X):-unlawful_assembly(X),force_used(X).
go_armed_unlawful(X):- (riot(X)),deadly_weapon(X).
guilty(X,Y):-member_of_unlawful_assembly(X),
		   offence_commited_in_prosecution_of_common_object(X).
/*unlawful assembly rule 151*/
guilty(X,Y):-more_than_five people(X),\+(criminal_force(X),govt(X);public_servant(X)).
		   
/*hiring, engagement or employment of any person to
join or become a member of any unlawful assembly*/
guilty(X,Y):- hiring_for_unlawful_asssembly(X).
guilty(X,Y):- (owner(X);occupier(X)),
			unlawful_assembly(X),
			knowledge(X),
			reason_to_believe(X)
			not_give_notice(X),
			use_lawful_powers_to_prevent_it(X).
			/*Rule 152 is done only 153 is left*/
guilty(X,Y):- assault_public_servant_suppressing_riot(X);
			obstruct_public_servant_suppressing_riot(X).		
guilty(X,Y):- (owner(X);occupier(X)),
			riot(X),
			knowledge(X),
			reason_to_believe(X),
			use_lawful_powers_to_prevent_it(X).
guilty(X,Y):- (owner(X);occupier(X)),
			riot(X),
			knowledge(X),
			not_give_notice(X),
			reason_to_believe(X),
			use_lawful_powers_to_prevent_it(X).
/*rule 157*/
guilty(X,Y):- (harbour(X);receives(X);assembles(X)),
			people_part of_unlawful_assembly(X),
			knowledge(X).
/*rule 158*/
			
guilty(X,Y):- (hired(X);engaged(X);assist_riot(X);(go_armed(X),causing_death(X))),
			riot(X),
			knowledge(X),
			reason_to_believe(X),
			use_lawful_powers_to_prevent_it(X).
/*rule 159 to define affray*/
affray(X):- multiple_persons(X),(fighting_in_public(X);disturb_peace(X)).
/*rule 160*/
guilty(X,Y):- affray(X).
