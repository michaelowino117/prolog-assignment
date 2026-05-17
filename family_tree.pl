% ============================================================
% FAMILY TREE PROLOG PROGRAM
% Multimedia University of Kenya - AI CAT May 2026
% Student: [Your Name]
% Reg No: [Your Reg Number]
% ============================================================

% ============================================================
% FACTS - Family Members and Relationships
% ============================================================

% --- GENERATION 1: Grandparents ---
male(john).
female(mary).
parent(john, robert).
parent(mary, robert).

male(george).
female(helen).
parent(george, linda).
parent(helen, linda).

% --- GENERATION 2: Parents ---
male(robert).
female(linda).
parent(robert, tom).
parent(robert, alice).
parent(linda, tom).
parent(linda, alice).

% --- GENERATION 2: Uncle (father's brother) ---
male(richard).
parent(john, richard).
parent(mary, richard).

% --- GENERATION 2: Aunt (father's sister) ---
female(susan).
parent(john, susan).
parent(mary, susan).

% --- GENERATION 2: Aunt (mother's sister) ---
female(patricia).
parent(george, patricia).
parent(helen, patricia).

% --- GENERATION 3: Children ---
male(tom).
female(alice).

% --- GENERATION 4: Grandchildren ---
male(jack).
female(emily).
parent(tom, jack).
parent(tom, emily).

% --- Cousins (children of uncle/aunt) ---
male(david).
female(sarah).
parent(richard, david).
parent(richard, sarah).

% --- Spouses ---
female(karen).
female(jessica).
married(john, mary).
married(george, helen).
married(robert, linda).
married(richard, karen).
married(tom, jessica).

% ============================================================
% RULES - Derived Relationships
% ============================================================

% Father: male parent
father(X, Y) :- male(X), parent(X, Y).

% Mother: female parent
mother(X, Y) :- female(X), parent(X, Y).

% Son: male child
son(X, Y) :- male(X), parent(Y, X).

% Daughter: female child
daughter(X, Y) :- female(X), parent(Y, X).

% Sibling: share at least one parent
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% Brother: male sibling
brother(X, Y) :- male(X), sibling(X, Y).

% Sister: female sibling
sister(X, Y) :- female(X), sibling(X, Y).

% Grandparent: parent of parent
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Grandfather: male grandparent
grandfather(X, Y) :- male(X), grandparent(X, Y).

% Grandmother: female grandparent
grandmother(X, Y) :- female(X), grandparent(X, Y).

% Grandchild: child of child
grandchild(X, Y) :- parent(Y, Z), parent(Z, X).

% Grandson: male grandchild
grandson(X, Y) :- male(X), grandchild(X, Y).

% Granddaughter: female grandchild
granddaughter(X, Y) :- female(X), grandchild(X, Y).

% Uncle: brother of parent
uncle(X, Y) :- brother(X, Z), parent(Z, Y).

% Aunt: sister of parent
aunt(X, Y) :- sister(X, Z), parent(Z, Y).

% Cousin: child of uncle/aunt
cousin(X, Y) :- uncle(Z, Y), parent(Z, X).
cousin(X, Y) :- aunt(Z, Y), parent(Z, X).

% Ancestor: recursive parent relationship
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% Descendant: recursive child relationship
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Y, Z), descendant(X, Z).

% ============================================================
% UTILITY PREDICATE - Display complete family info
% ============================================================
family_info(Person) :-
    format('~n=== FAMILY INFORMATION FOR ~w ===~n', [Person]),
    (father(F, Person) -> format('Father: ~w~n', [F]); true),
    (mother(M, Person) -> format('Mother: ~w~n', [M]); true),
    findall(S, sibling(Person, S), Sibs),
    (Sibs \= [] -> format('Siblings: ~w~n', [Sibs]); true),
    findall(GP, grandparent(GP, Person), GPs),
    (GPs \= [] -> format('Grandparents: ~w~n', [GPs]); true),
    findall(C, cousin(C, Person), Cs),
    (Cs \= [] -> format('Cousins: ~w~n', [Cs]); true),
    findall(U, uncle(U, Person), Us),
    (Us \= [] -> format('Uncles: ~w~n', [Us]); true),
    findall(A, aunt(A, Person), As),
    (As \= [] -> format('Aunts: ~w~n', [As]); true),
    findall(GC, grandchild(GC, Person), GCs),
    (GCs \= [] -> format('Grandchildren: ~w~n', [GCs]); true),
    format('===========================~n').
