# KakuroSolver
School project, implementing Kakuro Solver in Prolog..

"kakuro.pl" is a first attempt, it's not working nor finished though.. :)  
"kakuro_brute_force.pl" should work however (on 3x3 at least), it basically brute forces all options.
"kakuro_heuristic.pl" is hopefully final version, or at least it's very close to it.


**Format of games for kakuro_brute_force and kakuro_heuristic:**  
*edit - it's pretty slow, so this version is only working for like 3x3 kakuro*  

All possible games are "saved" in predicates "kakuro(Number, Board)" where Number is a unique index to hints(List) and 
Board is a given kakuro board with cells in following format:   
 - "o" - means empty placeholder cell  
 - control(X, Y) - control cell, controlling Sums in hints(List) at given indices X, Y  

You also have to save the hints(Index, List) in the corresponding predicate. The format is as follows:
hints(Index, [[oo],[Sum1,[X1, Y1],[X2,Y2],...] [Sum2,...]...]), where:
- Index is the index to the corresponding board
- [oo] is a placeholder control cell, used for incomplete control cells, must be first in every hints list
- SumN is N-th sum, where N is index used in control cells
- following tuples are indices to board that must fill the Sum

**_for the kakuro_heuristic_**  
You also have to save the hintsFreeCells(Index, List), because this version fills the board hint by hint, not in a straight-forward way.   
List has the following format: [[Sum1, _, _,...],[Sum2,...],...] where:  
- SumN is the N-th sum, same as in hints  
- instead of tuples of coordinates to board, there are free variables (that are later inserted to board)  
