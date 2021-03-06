%%%%%%%%%%%%%%%%%%%%%%%%%
%%% user interaction %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%+IndexOfProblem, +X - Board and its index to be printed
output(IndexOfProblem,X) :-
    writeBoardLineByLine(IndexOfProblem,X),!.

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
    fillHintsWithNumbers(1,[[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]).
kakuro(a1, [[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]) :-
    fillHintsWithNumbers(a1, [[o, control(2,1),control(3,1)],[control(1,4),_,_],[control(1,5),_,_]]).
%second part of problems, 4x4
%problem no.2, 4x4
kakuro(2, [[o, control(2,1),control(3,1),control(4,1)],[control(1,5),_,_,_],[control(1,6),_,_,_],[control(1,7),_,_,_]]) :-
    fillHintsWithNumbers(2, [[o, control(2,1),control(3,1),control(4,1)],[control(1,5),_,_,_],[control(1,6),_,_,_],[control(1,7),_,_,_]]).
%third part, 5x5
%problem no.3, 5x5
kakuro(3, [[o, o, control(2,1),control(3,1),o],[o,control(4,5),_,_,control(6,1)],[control(1,7),_,_,_,_],[control(1,8),_,_,_,_],[o,control(1,9),_,_,o]]) :-
    fillHintsWithNumbers(3, [[o, o, control(2,1),control(3,1),o],[o,control(4,5),_,_,control(6,1)],[control(1,7),_,_,_,_],[control(1,8),_,_,_,_],[o,control(1,9),_,_,o]]).
%final part, 9x8
%problem no.4
kakuro(4, [[o, o, o, control(2,1), control(3,1),o,o,o],[o,control(4,1),control(5,6),_,_,control(7,1),o,o],[control(1,8),_,_,_,_,_,control(9,1),o],[control(1,10),_,_,o,control(11,12),_,_,o],[o,o,control(13,1),control(14,15),_,_,_,o],[o,control(1,16),_,_,_,o,control(17,1),control(18,1)],[o,control(1,19),_,_,control(20,1),control(21,22),_,_],[o,o,control(1,23),_,_,_,_,_],[o,o,o,control(1,24),_,_,o,o]]) :- fillHintsWithNumbers(4,[[o, o, o, control(2,1), control(3,1),o,o,o],[o,control(4,1),control(5,6),_,_,control(7,1),o,o],[control(1,8),_,_,_,_,_,control(9,1),o],[control(1,10),_,_,o,control(11,12),_,_,o],[o,o,control(13,1),control(14,15),_,_,_,o],[o,control(1,16),_,_,_,o,control(17,1),control(18,1)],[o,control(1,19),_,_,control(20,1),control(21,22),_,_],[o,o,control(1,23),_,_,_,_,_],[o,o,o,control(1,24),_,_,o,o]]).
kakuro(a4, [[o,o,control(2,1),control(3,1),o,o,o,o],[o,control(4,5),_,_,control(6,1),o,o,o],[control(1,7),_,_,_,_,control(8,1),o,o],[control(1,9),_,_,control(1,10),_,_,control(11,1),o],[control(1,12),_,_,control(13,1),control(1,14),_,_,control(15,1)],[o,control(1,16),_,_,control(17,1),control(1,18),_,_],[o,o,control(1,19),_,_,control(20,21),_,_],[o,o,o,control(1,22),_,_,_,_],[o,o,o,o,control(1,23),_,_,o]]) :-
    fillHintsWithNumbers(a4,[[o,o,control(2,1),control(3,1),o,o,o,o],[o,control(4,5),_,_,control(6,1),o,o,o],[control(1,7),_,_,_,_,control(8,1),o,o],[control(1,9),_,_,control(1,10),_,_,control(11,1),o],[control(1,12),_,_,control(13,1),control(1,14),_,_,control(15,1)],[o,control(1,16),_,_,control(17,1),control(1,18),_,_],[o,o,control(1,19),_,_,control(20,21),_,_],[o,o,o,control(1,22),_,_,_,_],[o,o,o,o,control(1,23),_,_,o]]).

hints(1,[[oo],[13,[2,2],[3,2]],[9,[2,3],[3,3]],[17,[2,2],[2,3]],[5,[3,2],[3,3]]]).
hints(a1,[[oo],[11,[2,2],[3,2]],[6,[2,3],[3,3]],[13,[2,2],[2,3]],[4,[3,2],[3,3]]]).
hints(2,[[oo],[17,[2,2],[3,2],[4,2]],[12,[2,3],[3,3],[4,3]],[10,[2,4],[3,4],[4,4]],[23,[2,2],[2,3],[2,4]],[9,[3,2],[3,3],[3,4]],[7,[4,2],[4,3],[4,4]]]).
hints(3, [[oo],[19,[2,3],[3,3],[4,3],[5,3]],[11,[2,4],[3,4],[4,4],[5,4]],[14,[3,2],[4,2]],[9,[2,3],[2,4]],[5,[3,5],[4,5]],[11,[3,2],[3,3],[3,4],[3,5]],[26,[4,2],[4,3],[4,4],[4,5]],[3,[5,3],[5,4]]]).
hints(4, [[oo],[5,[2,4],[3,4]],[8,[2,5],[3,5]],[14,[3,2],[4,2]],[5,[3,3],[4,3]],[6,[2,4],[2,5]],[22,[3,6],[4,6],[5,6]],[27,[3,2],[3,3],[3,4],[3,5],[3,6]],[9,[4,7],[5,7]],[6,[4,2],[4,3]],[14,[5,5],[6,5]],[13,[4,6],[4,7]],[10,[6,3],[7,3]],[22,[6,4],[7,4],[8,4]],[20,[5,5],[5,6],[5,7]],[21,[6,3],[6,4],[6,5]],[9,[7,7],[8,7]],[3,[7,8],[8,8]],[7,[7,3],[7,4]],[13,[8,5],[9,5]],[3,[8,6],[9,6]],[6,[7,7],[7,8]],[22,[8,4],[8,5],[8,6],[8,7],[8,8]],[9,[9,5],[9,6]]]).
hints(a4, [[oo],[32,[2,3],[3,3],[4,3],[5,3],[6,3]],[7,[2,4],[3,4]],[8,[3,2],[4,2],[5,2]],[8,[2,3],[2,4]],[10,[3,5],[4,5]],[28,[3,2],[3,3],[3,4],[3,5]],[5,[4,6],[5,6]],[4,[4,2],[4,3]],[6,[4,5],[4,6]],[31,[5,7],[6,7],[7,7],[8,7],[9,7]],[10,[5,2],[5,3]],[15,[6,4],[7,4]],[3,[5,6],[5,7]],[8,[6,8],[7,8],[8,8]],[13,[6,3],[6,4]],[11,[7,5],[8,5]],[10,[6,7],[6,8]],[15,[7,4],[7,5]],[15,[8,6],[9,6]],[11,[7,7],[7,8]],[23,[8,5],[8,6],[8,7],[8,8]],[11,[9,6],[9,7]]]).

hintsFreeCells(1, [[13,_,_],[9,_,_],[17,_,_],[5,_,_]]).
hintsFreeCells(a1, [[11,_,_],[6,_,_],[13,_,_],[4,_,_]]).
hintsFreeCells(2,[[17,_,_,_],[12,_,_,_],[10,_,_,_],[23,_,_,_],[9,_,_,_],[7,_,_,_]]).
hintsFreeCells(3,[[19,_,_,_,_],[11,_,_,_,_],[14,_,_],[9,_,_],[5,_,_],[11,_,_,_,_],[26,_,_,_,_],[3,_,_]]).
hintsFreeCells(4, [[5,_,_],[8,_,_],[14,_,_],[5,_,_],[6,_,_],[22,_,_,_],[27,_,_,_,_,_],[9,_,_],[6,_,_],[14,_,_],[13,_,_],[10,_,_],[22,_,_,_],[20,_,_,_],[21,_,_,_],[9,_,_],[3,_,_],[7,_,_],[13,_,_],[3,_,_],[6,_,_],[22,_,_,_,_,_],[9,_,_]]).
hintsFreeCells(a4, [[32,_,_,_,_,_],[7,_,_],[8,_,_,_],[8,_,_],[10,_,_],[28,_,_,_,_],[5,_,_],[4,_,_],[6,_,_],[31,_,_,_,_,_],[10,_,_],[15,_,_],[3,_,_],[8,_,_,_],[13,_,_],[11,_,_],[10,_,_],[15,_,_],[15,_,_],[11,_,_],[23,_,_,_,_],[11,_,_]]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% "AI" itself %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fillHintsWithNumbers(IndexOfProblem, Board) :-
    hintsFreeCells(IndexOfProblem, List),
    hints(IndexOfProblem, [_|Hints]),
    fillHints(List, Hints, Board, NewBoard),
    checkHints(IndexOfProblem, NewBoard),
    output(IndexOfProblem, NewBoard).

%recursively fills in hints, one by one
fillHints([], _, Board, Board).
fillHints([Head|Rest], [HeadHint|Hints], Board, NewBoard) :-
    fillHint(Head, HeadHint, Board, CurBoard),
    fillHints(Rest, Hints, CurBoard, NewBoard).

%fills one specific hint in format [X,_,_,...]
fillHint([Sum|Rest], [Sum|RestHint], Board, NewBoard) :-
    fillRestHints(Sum, 0, [], Rest, RestHint, Board, NewBoard).

% the main "heuristic" part
% - at first, it looks whether the nextElement has not been generated yet
%- Also only inserts unique numbers, always checks if currentSum is less than final Sum
%- if there is only one element left, it is unified
% with Sum - CurrentSum
fillRestHints(_,_,_,[],[],Board,Board).
fillRestHints(Sum, IncompleteSum, CompleteHint,[NextElement|Rest], [[I, J]|RestHint], Board, NewBoard) :-
    index(Board, I, J, NextElement),
    nonvar(NextElement) ->                               %this element has been generated before
    not(member(NextElement, CompleteHint)),
    NewSum is IncompleteSum + NextElement,
    Sum >= NewSum,
    fillRestHints(Sum, NewSum, [CompleteHint,NextElement],Rest, RestHint, Board, NewBoard);
    (Rest = [] ->                                 %last element of the hint
    %if
    NextElement is Sum - IncompleteSum,          %try to unify with rest to sum
    substituteNumber(NextElement),
    not(member(NextElement, CompleteHint)),
    insertToMatrix(NextElement, Board, NewBoard, I, J);
    %else
    substituteNumber(NextElement),
    not(member(NextElement, CompleteHint)),
    NewSum is IncompleteSum + NextElement,
    Sum > NewSum,
    insertToMatrix(NextElement, Board, CurBoard, I, J),
    fillRestHints(Sum, NewSum, [CompleteHint,NextElement], Rest, RestHint, CurBoard, NewBoard)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% auxiliary methods %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hint(Board, [_|Indices]) :-
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

%+List - determines, if a list contains no duplicate values
isSet(List) :-
  setof(X, member(X, List), Set),
  length(Set, Length),
  length(List, Length).

% +Indices, +Board, -List get a list of values at given indices of Board
getListFromIndices(Board, Indices, List) :-
    getListFromIndices(Board, Indices, [], UnflattenedList),
    flatten(UnflattenedList, List).

getListFromIndices(_, [], List, List).
getListFromIndices(Board, Indices, List, NewList):-
    Indices = [[Row,Column]|Rest],
    index(Board, Row, Column, Value),
    getListFromIndices(Board, Rest,[List,Value], NewList).


%indexing to two dimensional array
index(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).

%Used for substitution of numbers to cells
substituteNumber(9).
substituteNumber(8).
substituteNumber(7).
substituteNumber(6).
substituteNumber(5).
substituteNumber(4).
substituteNumber(3).
substituteNumber(2).
substituteNumber(1).

%Insert Value to Matrix at indices X, Y
% the insertto predicate handles the Matrix as if saved by columns, not
% rows, so we have to swap indices
insertToMatrix(Value, Matrix, NewMatrix, X, Y) :-
    inserto(Value, Matrix, NewMatrix, Y, X).

%following is a net code for inserting element to Matrix at X, Y
%source: http://stackoverflow.com/questions/35069340/insert-element-into-a-2d-list-in-prolog
inserto(_,[],[],_,_).
inserto(E,[[_|Xs]|Ys],[[E|Xs1]|Ys1],1,1) :-
                    !,inserto(E,[Xs|Ys],[Xs1|Ys1],0,0).

inserto(E,[[X]|Xs],[[X]|Xs1],0,0) :-
                    inserto(E,Xs,Xs1,0,0),!.

inserto(E,[[X|Xs]|Ys],[[X|Xs1]|Ys1],0,0) :-
                    inserto(E,[Xs|Ys],[Xs1|Ys1],0,0).

inserto(E,[[X|Xs]|Ys],[[X|Xs1]|Ys1],N,1) :-
                    N1 is N-1,
                    inserto(E,[Xs|Ys],[Xs1|Ys1],N1,1).

inserto(E,[Xs|Ys],[Xs|Ys1],N,M) :-
                    M1 is M-1,
                    inserto(E,Ys,Ys1,N,M1),!.
