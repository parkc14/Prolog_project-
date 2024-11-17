% define 2D point
point2d(_,_).

% Define a tolerance for floating-point comparisons
tolerance(10e-6).

% Check if vertical
vertical(point2d(X, _), point2d(X, _)).

% Check if horizontal
horizontal(point2d(_, Y), point2d(_, Y)).

% Check if three points lie on the same line
line(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
    % Checks if the slope of first two points match the last two points
    (Y2 - Y1) * (X3 - X2) =:= (Y3 - Y2) * (X2 - X1).

% Check if three points define a triangle
triangle(P1, P2, P3) :-
    % Checks if the points are not on the same line?
    \+ line(P1, P2, P3).

% Check if two floating-point numbers are approximately equal
equal_rounded(X, Y) :-
    tolerance(Tol),
    abs(X - Y) =< Tol.

% Calculate the distance between two points
distance(point2d(X1, Y1), point2d(X2, Y2), D) :-
    % D is the distance between the two points
    DX is X2 - X1,
    DY is Y2 - Y1,
    D is sqrt(DX * DX + DY * DY).

% Calculate the trianle side lengths
length(P1, P2, P3, D1, D2, D3) :-
    distance(P1, P2, D1),
    distance(P2, P3, D2),
    distance(P3, P1, D3).

% Check if a triangle is isosceles
isosceles(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    % Checks if two sides are equal
    (equal_rounded(D1, D2); equal_rounded(D1, D3); equal_rounded(D2, D3)).

% Check if a triangle is equilateral
equilateral(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    % Checks if all sides are equal
    equal_rounded(D1, D2), equal_rounded(D2, D3).

% Check if a triangle is right
right(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    % Checks if the Pythagorean theorem holds
    (equal_rounded(D1 * D1, D2 * D2 + D3 * D3);
     equal_rounded(D2 * D2, D1 * D1 + D3 * D3);
     equal_rounded(D3 * D3, D1 * D1 + D2 * D2)).


% Check if a triangle is scalene
scalene(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    % Checks if all sides are different
    \+ equal_rounded(D1, D2),
    \+ equal_rounded(D1, D3),
    \+ equal_rounded(D2, D3).


% Check if a triangle is obtuse
obtuse(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    \+ right(P1, P2, P3),
    % Checks if the longest side is greater than the sum of the other two sides squared
    ( D1 >= D2, D1 >= D3, X is D2 * D2 + D3 * D3, D1 * D1 > X;
      D2 >= D1, D2 >= D3, X is D1 * D1 + D3 * D3, D2 * D2 > X;
      D3 >= D1, D3 >= D2, X is D1 * D1 + D2 * D2, D3 * D3 > X).


% Check if a triangle is acute
acute(P1, P2, P3) :-
    triangle(P1, P2, P3),
    length(P1, P2, P3, D1, D2, D3),
    % Checks if the longest side is less than the sum of the other two sides squared
    D1 * D1 + D2 * D2 > D3 * D3,
    D1 * D1 + D3 * D3 > D2 * D2,
    D2 * D2 + D3 * D3 > D1 * D1.


% Check if points define a square
square(P1, P2, P3, P4) :-
    distance(P1, P2, D1),
    distance(P2, P3, D2),
    distance(P3, P4, D3),
    distance(P4, P1, D4),
    distance(P1, P3, D5),
    distance(P2, P4, D6),
    % Checks if all sides are equal 
    equal_rounded(D1, D2), equal_rounded(D2, D3), equal_rounded(D3, D4), equal_rounded(D5, D6).
query(line(point2d(0,0), point2d(2,4), point2d(5,0))).
query(line(point2d(0,0), point2d(3,2), point2d(6,4))).
query(line(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).


query(triangle(point2d(0,0), point2d(2,4), point2d(5,0))).
query(triangle(point2d(0,0), point2d(3,2), point2d(6,4))).
query(triangle(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).


query(equilateral(point2d(0,0), point2d(2,4), point2d(5,0))).
query(isosceles(point2d(0,0), point2d(2,4), point2d(5,0))).
query(right(point2d(0,0), point2d(2,4), point2d(5,0))).
query(scalene(point2d(0,0), point2d(2,4), point2d(5,0))).
query(acute(point2d(0,0), point2d(2,4), point2d(5,0))).
query(obtuse(point2d(0,0), point2d(2,4), point2d(5,0))).

query(equilateral(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(isosceles(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(right(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(scalene(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(acute(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(obtuse(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).

query(line(point2d(1,2), point2d(2,4), point2d(3,6))).
query(line(point2d(1,2), point2d(2,4), point2d(3,8))).
query(line(point2d(1,2), point2d(2,4), point2d(10,20))).

query(vertical(point2d(1,2), point2d(2,4))).
query(vertical(point2d(1,2), point2d(1,4))).
query(vertical(point2d(1,2), point2d(3,2))).

query(horizontal(point2d(1,2), point2d(2,4))).
query(horizontal(point2d(1,2), point2d(1,4))).
query(horizontal(point2d(1,2), point2d(3,2))).

query(triangle(point2d(1,2), point2d(2,4), point2d(3,6))).
query(triangle(point2d(1,2), point2d(2,4), point2d(3,8))).
query(triangle(point2d(1,2), point2d(2,4), point2d(10,20))).

query(triangle(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(equilateral(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(isosceles(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(right(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(scalene(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(acute(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(obtuse(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).

query(triangle(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(equilateral(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(isosceles(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(right(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(scalene(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(acute(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(obtuse(point2d(2,2), point2d(5,2), point2d(3.5,-2))).

query(triangle(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(equilateral(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(isosceles(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(right(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(scalene(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(acute(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(obtuse(point2d(0,0), point2d(-2,2), point2d(4,4))).

query(triangle(point2d(1,1), point2d(3,1), point2d(4,3))).
query(equilateral(point2d(1,1), point2d(3,1), point2d(4,3))).
query(isosceles(point2d(1,1), point2d(3,1), point2d(4,3))).
query(right(point2d(1,1), point2d(3,1), point2d(4,3))).
query(scalene(point2d(1,1), point2d(3,1), point2d(4,3))).
query(acute(point2d(1,1), point2d(3,1), point2d(4,3))).
query(obtuse(point2d(1,1), point2d(3,1), point2d(4,3))).

query(triangle(point2d(3,1), point2d(9,1), point2d(6,4))).
query(equilateral(point2d(3,1), point2d(9,1), point2d(6,4))).
query(isosceles(point2d(3,1), point2d(9,1), point2d(6,4))).
query(right(point2d(3,1), point2d(9,1), point2d(6,4))).
query(scalene(point2d(3,1), point2d(9,1), point2d(6,4))).
query(acute(point2d(3,1), point2d(9,1), point2d(6,4))).
query(obtuse(point2d(3,1), point2d(9,1), point2d(6,4))).

query(square(point2d(2,4),point2d(5,7),point2d(8,4),point2d(5,1))). /* yes */
query(square(point2d(2,4),point2d(5,7),point2d(8,4),point2d(5,0))). /* no */
query(square(point2d(3,1),point2d(2,4),point2d(5,5),point2d(6,2))). /* yes */
query(square(point2d(-1,1),point2d(-1,3),point2d(1,3),point2d(1,0))). /* no */
query(square(point2d(-1,1),point2d(-1,3),point2d(1,3),point2d(1,1))). /* yes */
query(square(point2d(5,4),point2d(5,1),point2d(2,1),point2d(2,4))). /* yes */
query(square(point2d(2,0),point2d(1,2),point2d(2,4),point2d(3,2))). /* no */


writeln(T) :- write(T), nl.

main:- forall(query(Q), Q -> (writeln('yes')) ; (writeln('no'))),
	halt.
