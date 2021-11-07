prefer(le, (all, price, 400, 1)).
prefer(ge, (all, price, 350, 1)).
prefer(min, (all, weight, 0, 1)).

% Expected outcome: An optimal solution should have a total price between 350 and 400, or as close to that range as possible. The weight should be as low as possible.