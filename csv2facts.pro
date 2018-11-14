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

read_sudoku :-
	read_and_process(0,0).
