# README(Instructions for Testing)
## Problem Handled: Problem 2: Indian Penal Code
Group 16
1. INDRANEEL GHOSH 2016B1A70938P <br/>
2. SATWADHI DAS 2016B4A70622P

**Note**:
Definition of a case is stored in the database. Each case is defined as a list of predicates that are true for it. 
Run the queries for testing. The predicate guilty(X) returns the rules applicable in a particular case. 
The predicate abettor(X) returns true if the queried person X is an abettor, else returns false.

**Instructions for Testing** <br />
Open the file 'Final Project.pl'.
For testing the clauses, perform the given sequences of inputs. The test cases are created on the basis of conversion of the IPC to prolog predicates.

**Examples**: <br />
?- guilty(hel). <br />
Output: Rule 78 is applicable  <br />
	true . <br />
?- abettor(ayush). <br />
Output: false. <br />
