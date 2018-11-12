
:- dynamic(value_at/3).
:- dynamic(deduced_value_at/3).
:- dynamic(retracted_cell/2).
:- dynamic(pending_cell/2).
:- dynamic(forbidden/3).
:- initialization(start).

/* GNU prolog doesn't seem to define the 'not' predicate mentioned in Clocksin & Mellish */
not(P) :- \+(P).
not_both(A, B) :- not(A), ! ; not(B), !.

not_equal(A, B) :- B \== A.

block_size(3).
board_size(N) :- block_size(S), N is S*S.
max_index(M) :- board_size(S), M is S - 1.

base(A, V) :- block_size(Max), V is (A//Max).

in_same_block(A, B) :- base(A, BaseA), base(B, BaseB), BaseA == BaseB.

neighbour(X, Y, NX, NY) :-
	index(NX), index(NY),
   	not_both(NX == X, NY == Y),
   	in_same_block(X, NX),
   	in_same_block(Y, NY).

filled(X,Y) :- value_at(X,Y,_), ! ; deduced_value_at(X,Y,_).

empty(X,Y) :- not(filled(X,Y)).

is_value_at(X,Y, V) :- value_at(X,Y,V), ! ; deduced_value_at(X,Y,V).

unique_in_row(Row, Val) :-
	not(is_value_at(Row, _, Val)).

unique_in_column(Column, Val) :-
	not(is_value_at(_, Column, Val)).

exists_in_block(Row, Col, V) :-
	is_value_at(Row, Col, V)
	;
	neighbour(Row, Col, X, Y),
	is_value_at(X, Y, V1),
	V == V1.

unique_in_block(Row, Col, V) :-
	not(exists_in_block(Row, Col, V)).

avail(X, Y, V) :-
	not(forbidden(X,Y,V)),
	unique_in_block(X, Y, V),
	unique_in_row(X, V),
	unique_in_column(Y, V),
	V @>= 1, board_size(S), V @=< S.

find_value_for(X,Y, V) :-
	is_value_at(X,Y,V), ! % if X,Y has a value, just return it and kill backtracking over it
   	;
	digit(V1), avail(X, Y, V1), V is V1.

empty_cell(X, Y) :-
	not(value_at(X,Y,_)),
	not(deduced_value_at(X,Y,_)).

next_cell2(X, Y, NX, NY) :-
	empty_cell(X,Y), NX is X, NY is Y, !
	;
	max_index(M),
	Y @< M, NX is X, inc(Y, Y2), NY is Y2, !
	;
	max_index(M),
	inc(X, X2), NX is X2, NY is 0, !.
	
add_value_at(X,Y,V) :-
	is_value_at(X, Y, V), !
   	;
   	assertz(deduced_value_at(X,Y,V)).
	/*writestring("added deduced value "), write_line(X, Y, V).*/

retract_xy(X, Y, V) :-
	deduced_value_at(X, Y, V),
   	retract(deduced_value_at(X, Y, V)),
	/*writestring("retracted "), write_line(X, Y, V),*/
	!
; 
	true.

remove_later_forbiddens(X, Y) :-
	next_cell(X, Y, NX, NY),
	retractall(forbidden(NX, NY, _)),
	remove_later_forbiddens(NX, NY), ! ; true.

add_retract(X, Y, V) :-
	value_at(X, Y, V), !
;
	add_value_at(X, Y, V)
;
	retract_xy(X, Y, V),
	asserta(forbidden(X, Y, V)),
	remove_later_forbiddens(X, Y).

sudoku2(X, Y) :-
	board_size(S),
	X == S
	;
	find_value_for(X, Y, V),
	add_retract(X, Y, V),
	next_cell2(X, Y, NX, NY),
	sudoku2(NX, NY).

dec(N, D) :- D is N - 1.
inc(N, I) :- I is N + 1.

write_line(X, Y, V) :-
	write(X), put_char(','), write(Y), put_char(','), write(V), nl.

any_cell_empty(X, Y) :-
	index(X), index(Y),
	empty(X,Y).

get_value_at(X, Y, V) :- value_at(X, Y, V) ; deduced_value_at(X, Y, V).

next_cell(X, Y, NX, NY) :-
	max_index(M),
	Y @< M, NX is X, inc(Y, Y2), NY is Y2, !
	;
	max_index(M),
	X @< M, inc(X, X2), NX is X2, NY is 0, !.
	
set(V, Val) :- V is Val.

start :-
	read_sudoku,
	sudoku2(0,0),
	max_index(M),
	print_sudoku(M),
	halt
	;
	any_cell_empty(X, Y),
	writestring("No Solution. Still empty: "), write_line(X, Y, ' '),
	listing(deduced_value_at),nl,
	listing(forbidden),nl,
	halt.
