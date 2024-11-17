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