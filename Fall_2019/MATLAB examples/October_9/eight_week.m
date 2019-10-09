function [] = eight_week(average)
%EIGHT_WEEK Print a sentence about your grade.
%   If your grade > 70, print a good sentence, otherwise print something
%   else. Takes the course average grade as an input and prints a message
%   to the console without returning and output.

if (average >= 70)
    fprintf("Eighth week and all is well!\n")
else
    fprintf("Please go see your advisor as soon as possible.\n")
end    

end

