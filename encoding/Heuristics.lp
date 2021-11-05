%preferuirement for minimizing an attribute
%prefer(component|all, attribute, min|max|Value)
%prefer(front_brake, price, min, 1).
prefer(all, price, min, 1).
%prefer(all, price, le, 50, 1).
prefer(bell, color, silver, 1).


#heuristic assign(C, A, V) : prefer(C, A, V, P). [56@P, init]

% try to ignore any non-neccesary components
#heuristic assign(C, A, V) : domain(C, A, V). [1, false]



#heuristic assign(C, A, V) : domain(C, A, V), pref(C). [1, true]


% #heuristic orders don't do the same things as weak constraints, need to find another way to try to minimize values

