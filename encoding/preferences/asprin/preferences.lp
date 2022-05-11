#include "defaults.lp".

% prefer(type, (Component|all, Attribute, Value), (Priority, Weight))
          
% prefer(min, (C|all, Attribute, _), (P, W))
% prefer(max, (C|all, Attribute, _), (P, W))
% prefer(attr, (C|all, Attribute, Value), (P, W))
% prefer(negattr, (C|all, Attribute, Value), (P, W))
% prefer(le|leR, (C|all, Attribute, Value), (P, W))
% prefer(ge|geR, (C|all, Attribute, Value), (P, W))
% prefer(comp, (C, _, _), (P, W))
% prefer(negcomp, (C, _, _), (P, W))

% Preferences with a different ID are in a separate preference statement, changing how they are treated in the pareto front
% Preferences of the same type with the same ID are treated as directly comparable

% the total for values is determined for preferences over all components
total(A, T) :- #sum{V, C, A : assign(C, A, V)} = T, property_val(_,A,_).

% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more optimal answers on the pareto front
#preference(weight(P), less(weight)) 
{
    S, A, C :: assign(C, A, S), prefer(min, (all, A, V), (P, W)); % #minimize statements
    -S, A, C :: assign(C, A, S), prefer(max, (all, A, V), (P, W)); % #maximize statements
    S, A, C :: assign(C, A, S), prefer(min, (C, A, V), (P, W));
    -S, A, C :: assign(C, A, S), prefer(max, (C, A, V), (P, W))
} : prefer((min;max), (_, _, _), (P, _)).



#preference(boundry(P), less(weight))
{
	W, A :: total(A, T), prefer(leR, (all, A, X), (P, W)), T >= X;
	W, A :: total(A, T), prefer(geR, (all, A, X), (P, W)), T <= X;
	W, A, C :: assign(C, A, T), prefer(leR, (C, A, X), (P, W)), T >= X;
	W, A, C :: assign(C, A, T), prefer(geR, (C, A, X), (P, W)), T <= X;
	T-X, A :: total(A, T), prefer(le, (all, A, X), (P, W)), T >= X;
	X-T, A :: total(A, T), prefer(ge, (all, A, X), (P, W)), T <= X;
	T-X, A, C :: assign(C, A, T), prefer(le, (C, A, X), (P, W)), T >= X;
	X-T, A, C :: assign(C, A, T), prefer(ge, (C, A, X), (P, W)), T <= X
} : prefer((ge;le), (_, _, _), (P, _)).


% Prefering or disprefering certain components
#preference(comp(P), less(weight))
{
	-W, C :: component(C), prefer(comp, (C, A, V), (P, W));
	-W, C :: not component(C), prefer(negcomp, (C, A, V), (P, W))
} : prefer((comp;negcomp), (_, _, _), (P, _)).


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attr(P), less(weight))
{    
    -W, C, A, V :: assign(C, A, V) , domain(C, A, V), prefer(attr, (C, A, V), (P, W));
    -W, C, A, V :: assign(C, A, V) , domain(C, A, V), prefer(attr, (all, A, V), (P, W));
    -W, C, A, V :: not assign(C, A, V) , domain(C, A, V), prefer(negattr, (C, A, V), (P, W));
    -W, C, A, V :: not assign(C, A, V) , domain(C, A, V), prefer(negattr, (all, A, V), (P, W))
} : prefer((attr;negattr), (_, _, _), (P, _)).



% Pareto preference to list the pareto front for the given preferences
#preference(par, pareto) {**boundry(X); **attr(X); **weight(X); **comp(X)}.
#optimize(par).
