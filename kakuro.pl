%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%user interaction%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%
/*
board(X) :-
    X = [[_1_1,_1_2,_1_3,_1_4,_1_5,_1_6,_1_7,_1_8,_1_9,_1_10,_1_11,_1_12,_1_13],   %1
      [_2_1,_2_2,_2_3,_2_4,_2_5,_2_6,_2_7,_2_8,_2_9,_2_10,_2_11,_2_12,_2_13],    %2
      [_3_1,_3_2,_3_3,_3_4,_3_5,_3_6,_3_7,_3_8,_3_9,_3_10,_3_11,_3_12,_3_13],    %3
      [_4_1,_4_2,_4_3,_4_4,_4_5,_4_6,_4_7,_4_8,_4_9,_4_10,_4_11,_4_12,_4_13],    %4
      [_5_1,_5_2,_5_3,_5_4,_5_5,_5_6,_5_7,_5_8,_5_9,_5_10,_5_11,_5_12,_5_13],    %5
      [_6_1,_6_2,_6_3,_6_4,_6_5,_6_6,_6_7,_6_8,_6_9,_6_10,_6_11,_6_12,_6_13],    %6
      [_7_1,_7_2,_7_3,_7_4,_7_5,_7_6,_7_7,_7_8,_7_9,_7_10,_7_11,_7_12,_7_13],    %7
      [_8_1,_8_2,_8_3,_8_4,_8_5,_8_6,_8_7,_8_8,_8_9,_8_10,_8_11,_8_12,_8_13],    %8
      [_9_1,_9_2,_9_3,_9_4,_9_5,_9_6,_9_7,_9_8,_9_9,_9_10,_9_11,_9_12,_9_13],    %9
      [_10_1,_10_2,_10_3,_10_4,_10_5,_10_6,_10_7,_10_8,_10_9,_10_10,_10_11,_10_12,_10_13],    %10
      [_11_1,_11_2,_11_3,_11_4,_11_5,_11_6,_11_7,_11_8,_11_9,_11_10,_11_11,_11_12,_11_13],    %11
      [_12_1,_12_2,_12_3,_12_4,_12_5,_12_6,_12_7,_12_8,_12_9,_12_10,_12_11,_12_12,_12_13],    %12
      [_13_1,_13_2,_13_3,_13_4,_13_5,_13_6,_13_7,_13_8,_13_9,_13_10,_13_11,_13_12,_13_13]].   %13
*/
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

%Sum - hints of kakuro, Indices are tuples indexing to board
hint([Sum|Indices]) :-
    getSumOfIndices(Indices,0, Value),
    Sum is Value.

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
