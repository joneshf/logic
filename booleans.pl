:- module(booleans,
          [and/2, or/2, nand/2, nor/2, xor/2, impl/2, equ/2
          , table/2
          , op(1200, fx,  not)
          , op(1100, xfy, and)
          , op(1100, xfy, or)
          , op(1100, xfy, nand)
          , op(1100, xfy, nor)
          , op(1100, xfy, xor)
          , op(1000, xfy, impl)
          , op(1000, xfy, equ)
          ]).

and(P, Q) :- P , Q.

or(P, Q) :- P ; Q.

nand(P, Q) :- not(and(P, Q)).

nor(P, Q) :- not(or(P, Q)).

xor(P, Q) :- (P , not(Q)) ; (not(P) , Q).

impl(P, Q) :- not(P) ; Q.

equ(P, Q) :- impl(P, Q) , impl(Q, P).

bool(true).
bool(false).

bools(Ps, Bs) :-
    bools(Ps, [], Boolified),
    reverse(Boolified, Bs).

bools([], Bs, Bs).
bools([P|Ps], Acc, Bs):-
    bool(P),
    bools(Ps, [P|Acc], Bs).

evaluate(Predicate, true) :- Predicate, !.
evaluate(_, false).

output([]) :- nl.
output([X|Xs]) :-
    write(X),
    write('\t'),
    output(Xs).

table(Ps, Pred) :-
    bools(Ps, Boolified),
    evaluate(Pred, Result),
    append(Boolified, [Result], Line),
    output(Line),
    false.
