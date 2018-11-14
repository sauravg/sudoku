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
index(0).
index(1).
index(2).
index(3).
index(4).
index(5).
index(6).
index(7).
index(8).

digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).

not(P) :- \+(P).
not_both(A, B) :- not(A), ! ; not(B), !.

not_equal(A, B) :- B \== A.

