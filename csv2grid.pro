:- initialization(start).

:- dynamic(value_at/3).

get_value_at(X, Y, V) :-
	value_at(X, Y, V), !
;
	V is 0.

start :-
	read_sudoku,
	print_sudoku(8).

