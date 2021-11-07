% Checks if the default is in conflict with a preference
defaultCheck(T, (C, A, V, ID)) :- default(T, (C, A, V, ID)), not prefer(_, (C, A, _, _)).
% Special cases for comp and negcomp, since they do not use 'Attribute'
defaultCheck(negcomp, (C, A, V, ID)) :- default(negcomp, (C, A, V, ID)), not prefer(_, (C, _, _, _)). % If there is any preference for a component, negcomp will be disabled
defaultCheck(comp, (C, A, V, ID)) :- default(comp, (C, A, V, ID)), not prefer(negcomp, (C, _, _, _)). % If there is a preference against a component, comp will be disabled



% min/max over all components
#minimize{V@P, A, C : assign(C, A, V), defaultCheck(min, (all, A, V, P))}.
#maximize{V@P, A, C : assign(C, A, V), defaultCheck(max, (all, A, V, P))}.

% min/max over specific component
#minimize{V@P, A, C : assign(C, A, V), defaultCheck(min, (C, A, V, P))}.
#maximize{V@P, A, C : assign(C, A, V), defaultCheck(max, (C, A, V, P))}.

% prefer/disprefer specific attribute
% note that this usually needs a higher priority than min/max over numeric values to have an effect
#maximize{1@P, V, A, C : assign(C, A, V), defaultCheck(attr, (all, A, V, P))}.
#maximize{1@P, V, A, C : assign(C, A, V), defaultCheck(attr, (C, A, V, P))}.

#minimize{1@P, V, A, C : assign(C, A, V), defaultCheck(negattr, (all, A, V, P))}.
#minimize{1@P, V, A, C : assign(C, A, V), defaultCheck(negattr, (C, A, V, P))}.


% prefer/disprefer components
#maximize{1@P, C : component(C), defaultCheck(comp, (C, _, _, P))}.
#minimize{1@P, C : component(C), defaultCheck(negcomp, (C, _, _, P))}.

% prefer a value greater equal or less equal
total(A, T) :- #sum{V, C, A : assign(C, A, V)} = T, defaultCheck((ge;le), (all, A, _, _)).
#minimize{T-X@P, A : total(A, T), defaultCheck(le, (all, A, X, P)), T >= X}.
#minimize{X-T@P, A : total(A, T), defaultCheck(ge, (all, A, X, P)), T <= X}.


