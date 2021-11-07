% pref(type, (...))
% pref(min, (C|all, Attribute, Priority))
% pref(max, (C|all, Attribute, Priority))
% pref(attr, (C|all, Attribute, Value, Priority))
% pref(negattr, (C|all, Attribute, Value, Priority))
% pref(le, (C|all, Attribute, Value, Priority))
% pref(ge, (C|all, Attribute, Value, Priority))
% pref(comp, (C, Priority))
% pref(negcomp, (C, Priority))



% min/max over all components
#minimize{S@P, A, C : assign(C, A, S), prefer(min, (all, A, P))}.
#maximize{S@P, A, C : assign(C, A, S), prefer(max, (all, A, P))}.

% min/max over specific component
#minimize{S@P, A, C : assign(C, A, S), prefer(min, (C, A, P))}.
#maximize{S@P, A, C : assign(C, A, S), prefer(max, (C, A, P))}.

% prefer/disprefer specific attribute
% note that this usually needs a higher priority than min/max over numeric values to have an effect
#maximize{1@P, V, A, C : assign(C, A, V), prefer(attr, (all, A, V, P))}.
#maximize{1@P, V, A, C : assign(C, A, V), prefer(attr, (C, A, V, P))}.

#minimize{1@P, V, A, C : assign(C, A, V), prefer(negattr, (all, A, V, P))}.
#minimize{1@P, V, A, C : assign(C, A, V), prefer(negattr, (C, A, V, P))}.


% prefer/disprefer components
#maximize{1@P, C : component(C), prefer(comp, (C, P))}.
#minimize{1@P, C : component(C), prefer(negcomp, (C, P))}.

% ge/le ?
total(A, T) :- #sum{V, C, A : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
#minimize{T-X@P, A : total(A, T), prefer(le, (all, A, X, P)), T >= X}.
#minimize{X-T@P, A : total(A, T), prefer(ge, (all, A, X, P)), T <= X}.


% if A exists, try to include B
% This rule would work both ways ...
#maximize{1@P, V, A, C, V2, A2, C2 : assign(C, A, V), assign(C2, A2, V2), prefer(C, A, V, C2, A2, V2, P)}.
