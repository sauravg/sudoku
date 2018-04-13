
get_value_or_space(Row, Col, V) :-
	value_at(Row, Col, V1), V is V1 + 48, !
	;
	V = 32.

print_row2(Row) :-
	index(Col),
	get_value_or_space(Row, Col, V), put(V), write(','),
	Col == 8.


start2 :-
	index(Row),
	print_row2(Row),nl,
	Row == 8,
	halt.
