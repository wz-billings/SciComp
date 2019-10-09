%{
Zane Billings and Dr. McNelis
Markov Chains in MATLAB
2019-10-02
Our MATLAB script from class where we learned Markov chain models.
%}
clc; clear all; close all;
% The matrix describing our probability coefficients is called the
%  transition matrix. All of the columns need to add to 1!!!!

M = [
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.2, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.2, 0.2, 0.4, 0.2, 0.0, 0.2, 0.2, 0.0, 0.0;
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.2, 0.2, 0.2, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.2, 0.4, 0.4, 0.4, 0.0, 0.2, 0.0, 0.0, 0.0;
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;
    0.0, 0.0, 0.0, 0.2, 0.0, 0.6, 0.8, 0.0, 1.0;
    ];

% Suppose there are three people playing the game. We have to set up a 
% column vector of their original positions at round n = 0. We put a 3 as
% the first entry since there are 3 people playing.
X_0 = [3; 0; 0; 0; 0; 0; 0; 0; 0];

% To find the probabilities where the pawns are at for round n = 1, we 
% multiply the transition matrix by X_0.
X_1 = M * X_0;
X_2 = M * X_1;

% We wanted to find X_6 without doing 6 calculations by hand.
% First we want to store all of our X vectors in one matrix.
Xmat = [X_0, X_1, X_2];

% Let's make X_3 in the fourth column of Xmat.
Xmat(:,4) = M * Xmat(:,3);
Xmat(:,5) = M * Xmat(:,4);

% What if we want to do this 15 or 20 times?
% We can use a loop instead of doing it by hand.
% Since we know exactly how many times we want to repeat the loop, we can
% use a `for` loop.
% This loop will do the same thing for all integer numbers i between 6 and
% 11, inclusive.
for i = 6:11
    % Xmat(:,i) = M * Xmat(:,i-1);
    Xmat(:,i) = M^(i-1) * Xmat(:,1);
end

%  Let's plot our values over time.  Note, to do this to look at
%  x0 values over time, x1 values over time, ....
%  we will plot the transpose of our Xmat
figure
plot(Xmat')
legend(["X0","X1","X2","X3","X4","X5","X6","X7","X8"])

% If we wanted to find the 100th X vector we could do a longer for loop or
% we could use the shorter formula we figured out in class.
X100 = M^100 * X_0

