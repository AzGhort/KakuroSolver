%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%user interaction%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%+IndexOfProblem, +X - Board and its index to be printed
output(IndexOfProblem,X) :-
    writeBoardLineByLine(IndexOfProblem,X).

%following methods only format board output
writeBoardLineByLine(_,[]).
writeBoardLineByLine(IndexOfProblem,[FirstRow|Rest]) :-
    writeCellByCell(IndexOfProblem,FirstRow),
    write('|'),nl,
    writeBoardLineByLine(IndexOfProblem,Rest).

writeCellByCell(_,[]).
writeCellByCell(IndexOfProblem,[Head|Rest]) :-
    Head = control(Index1, Index2) -> hints(IndexOfProblem,X),
    index(X, Index1, 1, Sum1),
    index(X, Index2, 1, Sum2),
    write('|'), format('~|~`0t~w~2+', Sum1), write('\\'), format('~|~`0t~w~2+', Sum2),
    writeCellByCell(IndexOfProblem,Rest);
    write('|__'),write(Head),write('__'),
    writeCellByCell(IndexOfProblem,Rest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% list of problems  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%first part of problems, 3x3
%problem no.1, 3x3 easy kakuro
kakuro(1, [[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]) :-
    fillBoardWithNumbers(1,[[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]).
kakuro(a1, [[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]) :-
    fillBoardWithNumbers(a1,[[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]).
%second part of problems, 4x4
%problem no.2, 4x4
kakuro(2, [[o, control(2,1),control(3,1),control(4,1)],[control(1,5),_,_,_],[control(1,6),_,_,_],[control(1,7),_,_,_]]) :-
    fillBoardWithNumbers(2, [[o, control(2,1),control(3,1),control(4,1)],[control(1,5),_,_,_],[control(1,6),_,_,_],[control(1,7),_,_,_]]).

hints(1,[[oo],[13,[2,2],[3,2]],[9,[2,3],[3,3]],[17,[2,2],[2,3]],[5,[3,2],[3,3]]]).
hints(a1,[[oo],[11,[2,2],[3,2]],[6,[2,3],[3,3]],[13,[2,2],[2,3]],[4,[3,2],[3,3]]]).
hints(2,[[oo],[17,[2,2],[3,2],[4,2]],[12,[2,3],[3,3],[4,3]],[10,[2,4],[3,4],[4,4]],[23,[2,2],[2,3],[2,4]],[9,[3,2],[3,3],[3,4]],[7,[4,2],[4,3],[4,4]]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% "AI" itself %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fillBoardWithNumbers(Index, Board) :-
    append(Board, Flattened),
    fillListWithNumbers(Flattened),
    solve(Index, Board).

fillListWithNumbers([]).
fillListWithNumbers([Head|Rest]) :-
    nonvar(Head),
    fillListWithNumbers(Rest);
    substituteNumber(Head),
    fillListWithNumbers(Rest).

solve(IndexOfProblem, Board) :-
    checkHints(IndexOfProblem, Board),
    output(IndexOfProblem, Board).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% checking invariants %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Sum - hints of kakuro, Indices are tuples indexing to board
hint(Board, [Sum|Indices]) :-
    getSumOfIndices(Board,Indices,Value),
    Sum is Value,
    getListFromIndices(Board, Indices, List),
    isSet(List).

%Next two procedures checks if all invariants given by hints hold
checkHints(IndexOfProblem, Board):-
    hints(IndexOfProblem, X),
    X = [_|Rest],   %first field of hintsList is a placeholder for incomplete control cells
    checkRestOfHints(Board, Rest).
checkRestOfHints(_,[]).
checkRestOfHints(Board,[First|Rest]):-
    hint(Board, First),
    checkRestOfHints(Board,Rest).

%+Indices, +LastValue, -Value
%Returns sum of values on the given indices of board
getSumOfIndices(Plan, Indices, Value) :-
    Indices = [[I, J]|Rest],
    index(Plan, I, J, FirstValue),
    getSumOfIndices(Plan,Rest, FirstValue, Value).

getSumOfIndices(_,[],X, X).
getSumOfIndices(Plan, Indices, LastValue,Value) :-
    Indices = [[I, J]|Rest],
    index(Plan, I, J, IndexedValue),
    NewValue is LastValue + IndexedValue,
    getSumOfIndices(Plan,Rest,NewValue,Value).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% auxiliary methods %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%indexing to two dimensional array
index(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).

%+List - determines, if a list contains no duplicate values
isSet(List) :-
  setof(X, member(X, List), Set),
  length(Set, Length),
  length(List, Length).

%Used for substitution of numbers to cells
substituteNumber(1).
substituteNumber(2).
substituteNumber(3).
substituteNumber(4).
substituteNumber(5).
substituteNumber(6).
substituteNumber(7).
substituteNumber(8).
substituteNumber(9).

% +Indices, +Board, -List get a list of values at given indices of Board
getListFromIndices(Board, Indices, List) :-
    getListFromIndices(Board, Indices, [], UnflattenedList),
    flatten(UnflattenedList, List).

getListFromIndices(_, [], List, List).
getListFromIndices(Board, Indices, List, NewList):-
    Indices = [[Row,Column]|Rest],
    index(Board, Row, Column, Value),
    getListFromIndices(Board, Rest,[List,Value], NewList).
