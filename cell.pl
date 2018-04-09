value_at(0,0,1).
value_at(0,2,3).
value_at(1,1,5).
value_at(2,1,8).
value_at(2,2,9).

index(0).
index(1).
index(2).

digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).


filled(X,Y) :- value_at(X,Y,_), ! ; clause(deduced_value_at(X,Y,_), _).

empty(X,Y) :- \+(filled(X,Y)).

is_value_at(X,Y, V) :- value_at(X,Y,V), ! ; clause(deduced_value_at(X,Y,V), _).

avail(V) :-
	\+(is_value_at(_, _, V)),
   	V @>= 1, V @=< 9.

can_fill(X,Y,V) :-
	is_value_at(X,Y,V), ! % look no further if V is the value at X,Y 
   	;
   	empty(X,Y),
   	avail(V).

find_value_for(X,Y, V) :-
	is_value_at(X,Y,V), ! % if X,Y has a value, just return it and kill backtracking over it
   	;
   	digit(V1), avail(V1), V is V1.


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
