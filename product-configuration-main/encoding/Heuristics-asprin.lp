% pref(type, (...))
% pref(min, (C|all, Attribute, ID))
% pref(max, (C|all, Attribute, ID))
% pref(attr, (C|all, Attribute, Value, ID))
% pref(negattr, (C|all, Attribute, Value, ID))
% pref(le, (C|all, Attribute, Value, ID))
% pref(ge, (C|all, Attribute, Value, ID))
% pref(comp, (C, ID))
% pref(negcomp, (C, ID))

% Preferences with a different ID are in a separate preference statement, changing how they are treated in the pareto front
% Preferences of the same type with the same ID are treated as directly comparable


% DEBUG: price calculation for checking the impact of preferences
price(T) :- #sum{V, C : assign(C, price, V)} = T.
weight(W) :- #sum{V, C : assign(C, size, V)} = W.
#show price/1.
#show weight/1.



% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more answers on the pareto front
#preference(minmax(ID), less(weight)) 
{
    S, A, C :: assign(C, A, S), prefer(min, (all, A, ID)); % #minimize statements
    -S, A, C :: assign(C, A, S), prefer(max, (all, A, ID)); % #maximize statements
    S, A, C :: assign(C, A, S), prefer(min, (C, A, ID));
    -S, A, C :: assign(C, A, S), prefer(max, (C, A, ID))
} : prefer((min;max), (_, _, ID)).



% For Less/Greater on all components the total is calculated seperately
total(A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
#preference(boundry(ID), less(weight))
{
	T-X, A :: total(A, T), prefer(le, (all, A, X, ID)), T >= X;
	X-T, A :: total(A, T), prefer(ge, (all, A, X, ID)), T <= X;
	T-X, A, C :: total(A, T), prefer(le, (C, A, X, ID)), T >= X;
	X-T, A, C :: total(A, T), prefer(ge, (C, A, X, ID)), T <= X
} : prefer((ge;le), (_, _, _, ID)).


% Prefering or disprefering certain components
#preference(comp(ID), poset)
{
	component(C) : domain(C, _, _), prefer(comp, (C, ID));
	not component(C) : domain(C, _, _), prefer(negcomp, (C, ID))
} : prefer(comp, (_, ID)).


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attr(ID), poset)
{    
    assign(C, A, V) : domain(C, A, V), prefer(attr, (C, A, V, ID));
    assign(C, A, V) : domain(C, A, V), prefer(attr, (all, A, V, ID));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (C, A, V, ID));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (all, A, V, ID))
} : prefer(attr, (_, _, _, ID)).



% Pareto preference to list the pareto front for the given preferences
#preference(all, pareto) {**boundry(X); **attr(X); **minmax(X); **comp(X)}.
#optimize(all).