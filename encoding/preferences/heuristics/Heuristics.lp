% prefer(type, (C|all, Attribute, Value, P))
          
% prefer(min, (C|all, Attribute, _, P))
% prefer(max, (C|all, Attribute, _, P))
% prefer(attr, (C|all, Attribute, Value, P))
% prefer(negattr, (C|all, Attribute, Value, P))
% prefer(le, (C|all, Attribute, Value, P))
% prefer(ge, (C|all, Attribute, Value, P))
% prefer(comp, (C, _, _, P))
% prefer(negcomp, (C, _, _, P))

% P gives the priority of an assignement
% These heuristics only guide the search, they do not mark or guarantee any optimal answers

#heuristic assign(C, A, V) : prefer(C, A, V, P). [20@P, init]

% try to ignore any non-neccesary components
#heuristic assign(C, A, V) : domain(C, A, V). [1, false]



#heuristic assign(C, A, V) : domain(C, A, V), pref(C). [1, true]


