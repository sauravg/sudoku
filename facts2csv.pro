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
