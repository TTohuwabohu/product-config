%requirement for minimizing an attribute
%req(component|all, attribute, min|max|Value)
%req(front_brake, price, min, 1).
req(all, price, min, 1).
%req(all, price, le, 50, 1).
req(bell, color, silver, 1).


#heuristic assign(C, A, V) : req(C, A, V, P). [56@P, init]

% try to ignore any non-neccesary components
#heuristic assign(C, A, V) : domain(C, A, V). [1, false]



#heuristic assign(C, A, V) : domain(C, A, V), pref(C). [1, true]