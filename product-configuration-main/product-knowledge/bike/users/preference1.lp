prefer(min, (all, price, 1)).
prefer(attr, (bell, color, silver, 1)).

% Expected outcome: the cheapest possible bell does not come in silver, so optimal solutions would have the minimum possible price, or the minimum possible price while including the cheapest possible silver bell
% An attribute preferation like this might be better as hard constraint
