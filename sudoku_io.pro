print_horiz_line(Len) :-
	index(I),
	writestring("+---"),
	I == Len,
	write('+'),
	nl.

write_int_or_space(V) :-
	V \== 0, write(V), !
	;
	write(' '), !.

print_row(Row, Len) :-
	index(Col),
	get_value_at(Row, Col, V),
	write('|'), write(' '), write_int_or_space(V), write(' '), 
	Col == Len.

print_all_rows(Count) :-
	index(Row),
	print_horiz_line(Count),
	print_row(Row, Count), write('|'), nl,
	Row == Count.
   
print_sudoku(MaxIndex) :-
	print_all_rows(MaxIndex),
	print_horiz_line(MaxIndex).

writestring([]).
writestring([H|T]) :- put(H), writestring(T).

