:- initialization(start).

start :-
	read_sudoku,
	listing(value_at).
