%{
MATH 340: 25 September, 2019
Zane and Dr. McNelis
%}

% A matrix is an array of (typically real) numbers.
% MATLAB is not symbolic and operates on numeric matrices by default.

% Running some example calculations:
sin(pi/6)
sqrt(6)

format long;
sqrt(6)

format rat;
% pi is NOT a rational number, but MATLAB approximates this for us.
pi
sin(pi/6)

format short; % Back to default

% Worksheet problem 1: use format long to get 10 decimal places.
a = sin(pi/12);
b = sqrt(15*exp(3)-7);
c = nthroot(52,3);
d = atan(27);
e = log(cos(pi/8)^2+2);

% A matrix is a rectangular array of numbers, and we describe it by the
% number of rows and columns it has. E.g. A(2,3) is the entry of the matrix
% A at row 2, column 3.
A = [1 2 3 4; 5, 6, 7, 8]; %OR you can do
% A = [
%     1 2 3 4
%     5 6 7 8
%     ];
% The ; at the end of a line suppresses the output of the line.

matrix2 = [2, 3, 4, 5, 6; 1, 2, 4, 5, 6; 7, 6, 8, 7, 11];

% Slicing matrices
row2 = matrix2(2,:);

% Worksheet problem 2
A = [9 2 0; 4 4 4; 4 4 4];
B = [9; 8; 0]; %OR [9 8 0]'; this is called the transpose operation.
C = A*B;
D = A^3;
E = A.^3;

% To multiply the matrices A and B, the number of columns of A must match
% the number of rows of B, otherwise the operation is not defined. The
% output matrix will have the same number of rows as A and the same number
% of columns as B.

% This implies that you can only do the operation A^3 if A is square
% (number of rows = number of columns).
% If we want to multiply or exponentiate the elements of a matrix rather
% than a matrix itself, this is called a component-wise operation. You need
% to specifiy either .* or .^ or ./ to do this. Watch out when you do
% divisions because both ./ and .\ are different in MATLAB.

% An array = a vector = matrix where one dimension is one.

% Plotting curves in MATLAB: need two vectors of values for a 2D plot.
x = -2:1:2; % Generates the sequence of numbers -2, -1, 0, 1, 2.

% Problem 3a
x = -4:0.01:4;
y = atan(x)./(x.^2+1);
plot(x,y);

% Problem 3b
x = -5:0.01:10;
f = exp(sin(x));
g = cos(x).*exp(sin(x));

plot(x,f,'b',x,g,'r')

