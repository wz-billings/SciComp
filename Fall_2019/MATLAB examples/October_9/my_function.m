function [out] = my_function(in)
%MY_FUNCTION This is an example function
%   This function returns the cube of the input value plus two.

% in, out, and this_is_a_local_variable have local scopes.
% in is a special type of local variable called a parameter.

this_is_a_local_variable = in .^ 3;

out = this_is_a_local_variable + 2;

fprintf("In: %f,\nOut: %f,\nLocal variable: %f\n",in,out,this_is_a_local_variable)
% Prints a string to the console window, %f is a placeholder for a floating
% point number.
end

