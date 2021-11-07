#include "defaults.lp".

% prefer(type, (Component|all, Attribute, Value, P))
          
% prefer(min, (C|all, Attribute, _, P))
% prefer(max, (C|all, Attribute, _, P))
% prefer(attr, (C|all, Attribute, Value, P))
% prefer(negattr, (C|all, Attribute, Value, P))
% prefer(le, (C|all, Attribute, Value, P))
% prefer(ge, (C|all, Attribute, Value, P))
% prefer(comp, (C, _, _, P))
% prefer(negcomp, (C, _, _, P))

% P gives the priority of an assignement



% min/max over all components
#minimize{V@P, A, C : assign(C, A, V), prefer(min, (all, A, V, P))}.
#maximize{V@P, A, C : assign(C, A, V), prefer(max, (all, A, V, P))}.

% min/max over specific component
#minimize{V@P, A, C : assign(C, A, V), prefer(min, (C, A, V, P))}.
#maximize{V@P, A, C : assign(C, A, V), prefer(max, (C, A, V, P))}.

% prefer/disprefer specific attribute
% note that this usually needs a higher priority than min/max over numeric values to have an effect
#maximize{1@P, V, A, C : assign(C, A, V), prefer(attr, (all, A, V, P))}.
#maximize{1@P, V, A, C : assign(C, A, V), prefer(attr, (C, A, V, P))}.

#minimize{1@P, V, A, C : assign(C, A, V), prefer(negattr, (all, A, V, P))}.
#minimize{1@P, V, A, C : assign(C, A, V), prefer(negattr, (C, A, V, P))}.


% prefer/disprefer components
#maximize{1@P, C : component(C), prefer(comp, (C, _, _, P))}.
#minimize{1@P, C : component(C), prefer(negcomp, (C, _, _, P))}.

% prefer a value greater equal or less equal
total(A, T) :- #sum{V, C, A : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
#minimize{T-X@P, A : total(A, T), prefer(le, (all, A, X, P)), T >= X}.
#minimize{X-T@P, A : total(A, T), prefer(ge, (all, A, X, P)), T <= X}.


