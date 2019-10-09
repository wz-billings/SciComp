%  Hoops tells us about Leslie matrices
%  Working with page 2 of the handout.  Arctic Terns:
%
%  Draw a transition diagram.  The nodes are the ages
%  the birds are allowed to go to.  Maximum age of these
%  birds is 3 and they never survive to be 4 years old.  =(
%
%  The table gives s'es and f's.  The s's give survival
%  probabilities.  The f's are birth rates, or fecundity
%
%            0.34          0.40          0.44
%   Circle 0 ---> Circle 1 ---> Circle 2 ---> Circle 3
%
%   Use f values to draw arrows from age group back to Circle 0
%
%   Deriving the equations
%
%   n0(t+1) = 0 n0(t) + 1.5 n1(t) + 1.8 n2(t) + 1.3 n3(t)
%   n1(t+1) = 0.34 n0(t)
%   n2(t+2) =           0.40 n1(t)
%   n3(t+1) =                       0.44 n2(t)
%

tern_leslie = [0.00, 1.5, 1.8, 1.3; ...
               0.34, 0.0, 0.0, 0.0; ...
               0.00, 0.40, 0.0, 0.0; ...
               0.00, 0.00, 0.44, 0.0]
           
%  Set the initial conditions: 25 at age 0, 54 at age 1, 
%  23 at age 2, 65 at age 3
tern_initial = [25; 54; 23; 65];

%  Want to find n-vector at 10 years.
%  To create a matrix that could hold all vectors of tern values
%  over the years
Nmat = [tern_initial];  

tern_10 = tern_leslie^(10)*tern_initial


%  If we want to plot population sizes over time, say to 
%  time t = 20
for i = 1:20
    %  In column (i+1) put the value of n at time i (recall
    %  column 1 holds value of n at time 0.
    
    Nmat(:,i+1) = tern_leslie^(i)*tern_initial;
end
plot(Nmat')
legend(["Age 0", "Age 1", "Age 2", "Age 3"])
xlabel("Years")
title("Arctic Terns over 20 Years")