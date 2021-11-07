#include "defaults.lp".


% prefer(type, (Component|all, Attribute, Value, ID))
          
% prefer(min, (C|all, Attribute, _, ID))
% prefer(max, (C|all, Attribute, _, ID))
% prefer(attr, (C|all, Attribute, Value, ID))
% prefer(negattr, (C|all, Attribute, Value, ID))
% prefer(le, (C|all, Attribute, Value, ID))
% prefer(ge, (C|all, Attribute, Value, ID))
% prefer(comp, (C, _, _, ID))
% prefer(negcomp, (C, _, _, ID))

% Preferences with a different ID are in a separate preference statement, changing how they are treated in the pareto front
% Preferences of the same type with the same ID are treated as directly comparable



% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more optimal answers on the pareto front
#preference(weight(ID), less(weight)) 
{
    S, A, C :: assign(C, A, S), prefer(min, (all, A, V, ID)); % #minimize statements
    -S, A, C :: assign(C, A, S), prefer(max, (all, A, V, ID)); % #maximize statements
    S, A, C :: assign(C, A, S), prefer(min, (C, A, V, ID));
    -S, A, C :: assign(C, A, S), prefer(max, (C, A, V, ID))
} : prefer((min;max), (_, _, _, ID)).



% For Less/Greater on all components the total is calculated seperately
total(A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
total(C, A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (C, A, _, _)).
#preference(boundry(ID), less(weight))
{
	T-X, A :: total(A, T), prefer(le, (all, A, X, ID)), T >= X;
	X-T, A :: total(A, T), prefer(ge, (all, A, X, ID)), T <= X;
	T-X, A, C :: total(C, A, T), prefer(le, (C, A, X, ID)), T >= X;
	X-T, A, C :: total(C, A, T), prefer(ge, (C, A, X, ID)), T <= X
} : prefer((ge;le), (_, _, _, ID)).


% Prefering or disprefering certain components
#preference(comp(ID), poset)
{
	component(C) : domain(C, _, _), prefer(comp, (C, A, V, ID));
	not component(C) : domain(C, _, _), prefer(negcomp, (C, A, V, ID))
} : prefer(comp, (_, _, _, ID)).


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attr(ID), poset)
{    
    assign(C, A, V) : domain(C, A, V), prefer(attr, (C, A, V, ID));
    assign(C, A, V) : domain(C, A, V), prefer(attr, (all, A, V, ID));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (C, A, V, ID));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (all, A, V, ID))
} : prefer(attr, (_, _, _, ID)).



% Pareto preference to list the pareto front for the given preferences
#preference(all, pareto) {**boundry(X); **attr(X); **weight(X); **comp(X); **defaults}.
#optimize(all).