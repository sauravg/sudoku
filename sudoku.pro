
:- dynamic(value_at/3).
:- dynamic(deduced_value_at/3).
:- initialization(start).

/* GNU prolog doesn't seem to define the 'not' predicate mentioned in Clocksin & Mellish */
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

filled(X,Y) :- value_at(X,Y,_), ! ; deduced_value_at(X,Y,_), !.

empty(X,Y) :- not(filled(X,Y)).

is_value_at(X,Y, V) :- value_at(X,Y,V), ! ; deduced_value_at(X,Y,V), !.

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
	unique_in_block(X, Y, V),
	unique_in_row(X, V),
	unique_in_column(Y, V),
	V @>= 1, board_size(S), V @=< S.

% if X,Y has a fixed value, just return it and never reconsider
find_value_for(X,Y, V) :-
	value_at(X,Y,V), !.

find_value_for(X,Y, V) :-
	digit(V), avail(X, Y, V).

empty_cell(X, Y) :-
	not(value_at(X,Y,_)),
	not(deduced_value_at(X,Y,_)).

next_cell_to_process(X, Y, NX, NY) :-
	empty_cell(X,Y), NX is X, NY is Y, !
	;
	max_index(M),
	Y @< M, NX is X, NY is Y + 1, !
	;
	NX is X + 1, NY is 0, !.
	
add_value_at(X,Y,V) :-
	is_value_at(X, Y, V), !
   	;
   	assertz(deduced_value_at(X,Y,V)).
	/*writestring("added deduced value "), write_line(X, Y, V).*/

remove_value_at(X, Y, V) :-
	retract(deduced_value_at(X, Y, V)).
	/*writestring("removed deduced value "), write_line(X, Y, V).*/

/* If the cell has a fixed value, do nothing, and don't
 * revist, i.e. cut backtracking */
save_revertible(X, Y, V) :-
	value_at(X, Y, V), !.

/* But if not, put it there */
save_revertible(X, Y, V) :-
	add_value_at(X, Y, V).

/* We are backgracking. Remove the value deduced previously and fail,
 * so a new value for this cell would be retried. */
save_revertible(X, Y, V) :-
	remove_value_at(X, Y, V),
	fail.

/* row index <= [0, board_size).
 * row == board_size => all rows filled */
process_cell(X, _) :-
	board_size(S),
	X == S.

process_cell(X, Y) :-
	find_value_for(X, Y, V),
	save_revertible(X, Y, V),
	next_cell_to_process(X, Y, NX, NY),
	process_cell(NX, NY).

any_cell_empty(X, Y) :-
	index(X), index(Y),
	empty(X,Y).

get_value_at(X, Y, V) :- value_at(X, Y, V) ; deduced_value_at(X, Y, V).

start :-
	read_sudoku,
	process_cell(0,0),
	max_index(M),
	print_sudoku(M),
	halt
	;
	any_cell_empty(X, Y),
	writestring("No Solution. Still empty: "), write_line(X, Y, ' '),
	listing(deduced_value_at),nl,
	halt.
