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

