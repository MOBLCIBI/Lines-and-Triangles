% Coordinates X and Y make a 2-D point if
point2d(X, Y) :-
  % 1) coordinate X is a number and
  number(X),
  % 2) coordinate Y is a number.
  number(Y).

% Two 2-D points are part of a vertical line if
% 1) both points have the same X-coordinate value
vertical(point2d(X, Y1), point2d(X, Y2)) :-
  % 2) and the points have different Y-coordinate values.
  Y1 \= Y2.

% Two 2-D points are part of a horizontal line if
% 1) both points have the same Y-coordinate value
horizontal(point2d(X1, Y), point2d(X2, Y)) :-
  % 2) and the points have different X-coordinate values.
  X1 \= X2.

% Three 2-D points are part of a line if
line(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) there are at least two separate points
  % 1a) meaning that there are at least two different X-coordinate values or
  (((X1 \= X2 ; X2 \= X3) ;
  % 1b) that there are at least two different Y-coordinate values
  (Y1 \= Y2 ; Y2 \= Y3)),
  % 2) and there is a uniform slope while accounting for only two points.
  ((((X1 =:= X2, Y1 =:= Y2), (X1 \= X3 ; Y1 \= Y3)) ;
  ((X1 =:= X3, Y1 =:= Y3), (X1 \= X2 ; Y1 \= Y2)) ;
  ((X2 =:= X3, Y2 =:= Y3), (X1 \= X3 ; Y1 \= Y3))) ;
  (((XChange1 is X2-X1,
  XChange2 is X3-X1),
  (YChange1 is Y2-Y1,
  YChange2 is Y3-Y1)),
  ((YChange1 / XChange1) =:= (YChange2 / XChange2))))).

% Three 2-D points are part of a triangle if
triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) there are actually three separate points and
  (((X1 \= X2 ; Y1 \= Y2),
  (X1 \= X3 ; Y1 \= Y3),
  (X2 \= X3 ; Y2 \= Y3)),
  % 2) the sum of any two sides is greater than the length of the third side.
  (SideA is
    float((round(1000000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/1000000000),
  SideB is
    float((round(1000000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/1000000000),
  SideC is
    float((round(1000000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/1000000000)),
  (((SideA + SideB) > SideC),
  ((SideB + SideC) > SideA),
  ((SideA + SideC) > SideB))).

% Three 2-D points are part of an isosceles triangle if
isosceles(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) at least two sides are equal length.
  (SideA is
    float((round(100000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/100000000),
  SideB is
    float((round(100000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/100000000),
  SideC is
    float((round(100000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/100000000)),
  ((SideA =:= SideB) ; (SideA =:= SideC) ; (SideB =:= SideC))).

% Three 2-D points are part of an equilateral triangle if
equilateral(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) all three sides are equal length.
  ((SideA is
    float((round(100000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/100000000),
  SideB is
    float((round(100000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/100000000),
  SideC is
    float((round(100000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/100000000)),
  (SideA =:= SideB, SideA =:= SideC))).

% Three 2-D points are part of a right pythagorean triangle if
right(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) the longest side actually matches the expected hypotenuse length.
  (SideA is
    float((round(100000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/100000000),
  SideB is
    float((round(100000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/100000000),
  SideC is
    float((round(100000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/100000000)),
  ((((SideA > SideB), (SideA > SideC)),
  (SideA =:=
    float((round(100000000*(sqrt((SideB**2)+(SideC**2)))))/100000000))) ;
  (((SideB > SideA), (SideB > SideC)),
  (SideB =:=
    float((round(100000000*(sqrt((SideA**2)+(SideC**2)))))/100000000))) ;
  (((SideC > SideA), (SideC > SideC)),
  (SideC =:=
    float((round(100000000*(sqrt((SideA**2)+(SideB**2)))))/100000000))))).

% Three 2-D points are part of a scalene triangle if
scalene(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) no two sides are of equal length.
  (SideA is
    float((round(100000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/100000000),
  SideB is
    float((round(100000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/100000000),
  SideC is
    float((round(100000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/100000000)),
  (((SideA \= SideB), (SideA \= SideC)), (SideB \= SideC))).

% Three 2-D points are part of an acute triangle if
acute(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) the longest side is smaller than a function of the other two sides.
  (SideA is
    float((round(1000000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/1000000000),
  SideB is
    float((round(1000000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/1000000000),
  SideC is
    float((round(1000000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/1000000000)),
  ((((SideA >= SideB), (SideA >= SideC)),
  (float((round(1000000000*(SideA**2)))/1000000000) <
    float((round(1000000000*((SideB**2)+(SideC**2))))/1000000000))) ;
  (((SideB >= SideA), (SideB >= SideC)),
  (float((round(1000000000*(SideB**2)))/1000000000) <
    float((round(1000000000*((SideA**2)+(SideC**2))))/1000000000))) ;
  (((SideC >= SideA), (SideC >= SideB)),
  (float((round(1000000000*(SideC**2)))/1000000000) <
    float((round(1000000000*((SideA**2)+(SideB**2))))/1000000000))))).

% Three 2-D points are part of an obtuse triangle if
obtuse(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)) :-
  % 1) the points are actually part of a triangle and
  (triangle(point2d(X1, Y1), point2d(X2, Y2), point2d(X3, Y3)),
  % 2) the longest side is greater than a function of the other two sides.
  (SideA is
    float((round(100000000*(sqrt(((X2-X1)**2)+((Y2-Y1)**2)))))/100000000),
  SideB is
    float((round(100000000*(sqrt(((X3-X2)**2)+((Y3-Y2)**2)))))/100000000),
  SideC is
    float((round(100000000*(sqrt(((X1-X3)**2)+((Y1-Y3)**2)))))/100000000)),
  ((((SideA > SideB), (SideA > SideC)),
  (float((round(100000000*(SideA**2)))/100000000) >
    float((round(100000000*((SideB**2)+(SideC**2))))/100000000))) ;
  (((SideB > SideA), (SideB > SideC)),
  (float((round(10000000*(SideB**2)))/10000000) >
    float((round(10000000*((SideA**2)+(SideC**2))))/10000000))) ;
  (((SideC > SideA), (SideC > SideB)),
  (float((round(100000000*(SideC**2)))/100000000) >
    float((round(100000000*((SideA**2)+(SideB**2))))/100000000))))).


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

writeln(T) :- write(T), nl.

main:- forall(query(Q), Q -> (write('yes	'),writeln(Q)) ; (write('no	'),writeln(Q))),
	halt.
