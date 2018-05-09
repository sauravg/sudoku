:- initialization(start).

maybe_read_again(Row, Col, MaxIndex) :-
	integer(MaxIndex), 	Row > MaxIndex
;
	read_and_process(Row, Col).

read_and_process(Row, Col) :-
	get0(C),
	process_char(C, Row, Col, NewRow, NewCol, MaxIndex),
	maybe_read_again(NewRow, NewCol, MaxIndex).

process_char(C, Row, Col, NewRow, NewCol, MaxIndex) :-
	/* comma. Just inrement the Col */
    C = 44, NewRow is Row, NewCol is Col + 1, !
;
	/* newline. Instantiate MaxIndex if not instantiated, or fail if Instantiated but not equal
       to the number of chars read for this Row (i.e. Col). Move to the next Row and reset Col */
	C = 10, MaxIndex is Col, NewRow is Row + 1, NewCol is 0, !
;
	/* 0 - 9. Insert a fact, but wait for the next Comma or Newline to increment Row,Col*/
	integer(C), C > 48, C =< 57,
   	V is C-48, assertz(value_at(Row, Col, V)),
   	NewRow is Row, NewCol is Col, !
;
	/* Ignore whatever it is */
	NewRow is Row, NewCol is Col.


start :-
	read_and_process(0, 0),
	listing(value_at).


writestring([]).
writestring([H|T]) :- put(H), writestring(T).

