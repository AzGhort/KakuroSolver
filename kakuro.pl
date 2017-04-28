%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%user interaction%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%



output :-
    board(X),
    writeBoardLineByLine(X).

writeBoardLineByLine([]).
writeBoardLineByLine([FirstRow|Rest]) :-
    writeCellByCell(FirstRow),
    nl,
    writeBoardLineByLine(Rest).

writeCellByCell([]).
writeCellByCell([Head|Rest]) :-
    Head = control(Index1, Index2) -> hintsList(X),
    index(X, Index1, 1, Sum1),
    index(X, Index2, 1, Sum2),
    write('|'),write(Sum1),write('\\'),write(Sum2);
    write('| '),write(Head),write(' |'),
    writeCellByCell(Rest).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  saving input board %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%+X - Saves X as current board
saveBoard(_) :-
    retract(board(_)),
    fail.
saveBoard(X) :-
    assert(board(X)).

%+X - Saves X as list of current hints
saveHints(_) :-
    retract(hintsList(_)),
    fail.
saveHints(X) :-
    assert(hintsList(X)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% checking invariants %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%+List - determines, if a list contains no duplicate values
isSet(List) :-
  setof(X, member(X, List), Set),
  length(Set, Length),
  length(List, Length).

%Sum - hints of kakuro, Indices are tuples indexing to board
hint([Sum|Indices]) :-
    getSumOfIndices(Indices,0, Value),
    Sum is Value,
    isSet(Indices).

%Next two procedures checks if all invariants given by hints hold
checkHints(X) :-
    hintsList(X),
    X = [First|Rest],
    hint(First),
    checkRestOfHints(Rest).
checkRestOfHints([]).
checkRestOfHints([First|Rest]):-
    hint(First),
    checkRestOfHints(Rest).

%+Indices, +LastValue, -Value
%Returns sum of values on the given indices of board
getSumOfIndices(Indices, Value) :-
    Indices = [[I, J]|Rest],
    board(Plan),
    index(Plan, I, J, Value),
    getSumOfIndices(Rest, Value, RestValue),
    Value is RestValue.

getSumOfIndices([],X, X).
getSumOfIndices(Indices, LastValue,Value) :-
    Indices = [[I, J]|Rest],
    board(Plan),
    index(Plan, I, J, IndexedValue),
    NewValue is LastValue + IndexedValue,
    getSumOfIndices(Rest,NewValue,Value).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% auxiliary methods %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%indexing to two dimensional array
index(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).
