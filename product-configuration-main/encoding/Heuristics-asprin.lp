% pref(type, (...))
% pref(min, (C|all, Attribute, Priority))
% pref(max, (C|all, Attribute, Priority))
% pref(attr, (C|all, Attribute, Value, Priority))
% pref(negattr, (C|all, Attribute, Value, Priority))
% pref(le, (C|all, Attribute, Value, Priority))
% pref(ge, (C|all, Attribute, Value, Priority))
% pref(comp, (C, Priority))
% pref(negcomp, (C, Priority))


% DEBUG: price calculation for checking the impact of preferences
price(T) :- #sum{V, C : assign(C, price, V)} = T.
#show price/1.


% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more answers on the pareto front
#preference(minmax, less(weight)) 
{
    S*P, A, C :: assign(C, A, S), prefer(min, (all, A, P)); % #minimize statements
    (-S)*P, A, C :: assign(C, A, S), prefer(max, (all, A, P)); % #maximize statements
    S*P, A, C :: assign(C, A, S), prefer(min, (C, A, P));
    (-S)*P, A, C :: assign(C, A, S), prefer(max, (C, A, P))
}.

% For Less/Greater on all components the total is calculated seperately
total(A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
#preference(boundry, less(weight))
{
	(T-X)*P, A :: total(A, T), prefer(le, (all, A, X, P)), T >= X;
	(X-T)*P, A :: total(A, T), prefer(ge, (all, A, X, P)), T <= X;
	(T-X)*P, A, C :: total(A, T), prefer(le, (C, A, X, P)), T >= X;
	(X-T)*P, A, C :: total(A, T), prefer(ge, (C, A, X, P)), T <= X
}.


% Prefering or disprefering certain components
#preference(comp, poset)
{
	component(C) : domain(C, _, _), prefer(comp, (C, _));
	not component(C) : domain(C, _, _), prefer(negcomp, (C, _))
}.


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attr, poset)
{    
    assign(C, A, V) : domain(C, A, V), prefer(attr, (C, A, V, P));
    assign(C, A, V) : domain(C, A, V), prefer(attr, (all, A, V, P));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (C, A, V, P));
    not assign(C, A, V) : domain(C, A, V), prefer(negattr, (all, A, V, P))
}.



% Pareto preference to list the pareto front for the given preferences
#preference(all, pareto) {**boundry; **attr; **minmax; **comp}.
#optimize(all).