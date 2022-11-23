male(charles).
male(edward).
male(andrew).
male(william).
male(george).
male(louis).
male(harry).

female(elizabeth).
female(ann).
female(charlotte).

child(charles, elizabeth).
child(ann, elizabeth).
child(andrew, elizabeth).
child(edward, elizabeth).
child(william, charles).
child(harry, charles).
child(george, william).
child(charlotte, william).
child(louis, william).

older_than(charles, ann).
older_than(charles, andrew).
older_than(charles, edward).
older_than(ann, andrew).
older_than(ann, edward).
older_than(andrew, edward).
older_than(william, harry).
older_than(george, charlotte).
older_than(charlotte, louis).
older_than(george, louis).

son(X,Y) :- child(X,Y), male(X).

daughter(X,Y) :- child(X,Y), female(X).

successor(X, Y):- child(Y,X).
%successor(X, Y):- son(Y,X).
%successor(X, Y):- daughter(Y,X).

successionList(X, SuccessionList):-
	findall(Y, successor(X, Y), SuccessionList).

precedes(X,Y):- male(X), male(Y), older_than(X,Y).
precedes(X,Y):- male(X), female(Y), Y\=elizabeth.
precedes(X,Y):- female(X), female(Y), older_than(X,Y).

%precedes(X,Y):- older_than(X,Y).

%% Sorting algorithm
succession_sort([A|B], Sorted) :- succession_sort(B, SortedTail), insert(A, SortedTail, Sorted).
succession_sort([], []).

insert(A, [B|C], [B|D]) :- not(precedes(A,B)), !, insert(A, C, D).
insert(A, C, [A|C]).




successionListIndependent(X, SuccessionList):-
	findall(Y, child(Y,X), Children),
	succession_sort(Children, SuccessionList).


