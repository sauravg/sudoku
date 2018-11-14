/*
 * Copyright (C) 2018 Saurav Ghosh <sauravg@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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

write_line(X, Y, V) :-
	write(X), put_char(','), write(Y), put_char(','), write(V), nl.

