function [new_score] = darts(x, y, current_score)
%DARTS Calculate the new darts score.
%   Takes x, y, and the current score as the output, computes the number of
%   points by which the score should increase, prints a message about the
%   score, and returns the updated score.

% First, calculate the distance between the center of the board at (5,5)
% and the input coordinate.
distance = sqrt((x - 5)^2 + (y - 5)^2);

if distance <= 1
    points = 20;
    message = "Great work! Close to the bullseye!\n";
elseif distance <= 3
    points = 10;
    message = "Not bad. You are in the yellow ring!\n";
elseif distance <= 6
    points = 5;
    message = "Keep practicing!\n";
else
    points = -2;
    message = "Perhaps you should take up hopscotch...\n";
end

new_score = current_score + points;
fprintf(message)

end

