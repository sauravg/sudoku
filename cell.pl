value_at(0,4,1).
value_at(0,5,5).
value_at(0,6,6).
value_at(0,8,9).
value_at(1,1,2).
value_at(1,3,7).
value_at(1,8,1).
value_at(2,0,0).
value_at(2,7,7).
value_at(3,1,1).
value_at(3,4,9).
value_at(3,5,8).
value_at(3,8,5).
value_at(4,2,6).
value_at(4,6,9).
value_at(5,0,3).
value_at(5,3,5).
value_at(5,4,7).
value_at(5,7,6).
value_at(6,1,4).
value_at(6,8,2).
value_at(7,0,2).
value_at(7,5,4).
value_at(7,7,9).
value_at(8,0,7).
value_at(8,2,5).
value_at(8,3,1).
value_at(8,4,2).

index(0).
index(1).
index(2).
index(3).
index(4).
index(5).
index(6).
index(7).
index(8).

digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).

not_equal(A, B) :- B \== A.

base3(A, V) :- V is 3*(A//3).

greater3(A, B) :-
	base3(A, RHS),
	B @>= RHS.


add3(A, B) :- B is A + 3.

less3(A, B) :-
	base3(A, X),
	RHS is X + 3,
	B @< RHS.

in_same_block(A, B) :- greater3(A, B), less3(A, B).

neighbour(A, B) :- index(I), in_same_block(A, I), B is I.

filled(X,Y) :- value_at(X,Y,_), ! ; clause(deduced_value_at(X,Y,_), _).

empty(X,Y) :- \+(filled(X,Y)).

is_value_at(X,Y, V) :- value_at(X,Y,V), ! ; clause(deduced_value_at(X,Y,V), _).

unique_in_row(Row, Val) :-
	\+(is_value_at(Row, _, Val)).

unique_in_column(Column, Val) :-
	\+(is_value_at(_, Column, Val)).

exists_in_block(Row, Col, V) :-
	neighbour(Row, X),
	neighbour(Col, Y),
/*	write(X), put_char(','), write(Y), nl, */
	is_value_at(X, Y, V1),
	V == V1.

unique_in_block(Row, Col, V) :-
	\+(exists_in_block(Row, Col, V)).

avail(X, Y, V) :-
	unique_in_block(X, Y, V),
	unique_in_row(X, V),
	unique_in_column(Y, V),
	V @>= 1, V @=< 9.

find_value_for(X,Y, V) :-
	is_value_at(X,Y,V), ! % if X,Y has a value, just return it and kill backtracking over it
   	;
	digit(V1), avail(X, Y, V1), V is V1.


find_single_value_for(X,Y, V) :- find_value_for(X, Y, V), !.

add_value_at(X,Y,V) :-
	value_at(X, Y, V), !
   	;
   	assertz(deduced_value_at(X,Y,V)).

write_line(X, Y, V) :-
	write(X), put_char(','), write(Y), put_char(','), write(V), nl.

has_empty :-
	index(X), index(Y),
	empty(X,Y).

solve_block :- 
	index(X), index(Y),
   	find_single_value_for(X, Y, V),
   	add_value_at(X,Y,V),
   	write_line(X, Y, V),
	has_empty.
