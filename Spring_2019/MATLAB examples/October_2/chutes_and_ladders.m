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

