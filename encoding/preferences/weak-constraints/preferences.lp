#include "scoring.lp".

% prefer(type, (Component|all, Attribute, Value), (Priority, Weight))
          
% prefer(min, (C|all, Attribute, _), (P, W))
% prefer(max, (C|all, Attribute, _), (P, W))
% prefer(attr, (C|all, Attribute, Value), (P, W))
% prefer(negattr, (C|all, Attribute, Value), (P, W))
% prefer(le|leR, (C|all, Attribute, Value), (P, W))
% prefer(ge|geR, (C|all, Attribute, Value), (P, W))
% prefer(comp, (C, _, _), (P, W))
% prefer(negcomp, (C, _, _), (P, W))


% the total for values is determined for preferences over all components
total(A, T) :- #sum{V, C, A : assign(C, A, V)} = T, property_val(_,A,_).

% min/max over all components
#minimize{T@P, A, C : assign(C, A, V), total(A, T), prefer(min, (all, A, _), (P, W))}.
#maximize{T@P, A, C : assign(C, A, V), total(A, T), prefer(max, (all, A, _), (P, W))}.

% min/max over specific component
#minimize{V@P, A, C : assign(C, A, _), score(C, A, V), prefer(min, (C, A, _), (P, W))}.
#maximize{V@P, A, C : assign(C, A, _), score(C, A, V), prefer(max, (C, A, _), (P, W))}.

% prefer/disprefer specific attribute
#maximize{W@P, V, A, C : assign(C, A, V), prefer(attr, (all, A, V), (P, W))}.
#maximize{W@P, V, A, C : assign(C, A, V), prefer(attr, (C, A, V), (P, W))}.

#minimize{W@P, V, A, C : assign(C, A, V), prefer(negattr, (all, A, V), (P, W))}.
#minimize{W@P, V, A, C : assign(C, A, V), prefer(negattr, (C, A, V), (P, W))}.


% prefer/disprefer components
#maximize{W@P, C : component(C), prefer(comp, (C, _, _), (P, W))}.
#minimize{W@P, C : component(C), prefer(negcomp, (C, _, _), (P, W))}.

% prefer a value greater equal or less equal for all/specific components
% a fixed cost is incured if the preference is not statisfied
#minimize{W@P, A : total(A, T), prefer(leR, (all, A, X),(P, W)), T >= X}.
#minimize{W@P, A : total(A, T), prefer(geR, (all, A, X), (P, W)), T <= X}.

#minimize{W@P, A : assign(C, A, V), prefer(leR, (C, A, X), (P, W)), V >= X}.
#minimize{W@P, A : assign(C, A, V), prefer(geR, (C, A, X), (P, W)), V <= X}.


% prefer a value greater equal or less equal for all/specific components
% the cost incured depends on how far away the actual value is from the threshold
#minimize{T-X@P, A : total(A, T), prefer(le, (all, A, X),(P, W)), T >= X}.
#minimize{X-T@P, A : total(A, T), prefer(ge, (all, A, X), (P, W)), T <= X}.

#minimize{V-X@P, A : assign(C, A, V), prefer(le, (C, A, X), (P, W)), V >= X}.
#minimize{X-V@P, A : assign(C, A, V), prefer(ge, (C, A, X), (P, W)), V <= X}.
