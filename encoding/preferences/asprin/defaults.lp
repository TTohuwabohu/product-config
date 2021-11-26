% Same structure as prefer:
% default(type, (C|all, Attribute, Value, ID))

% default(min, (C|all, Attribute, _, ID))
% default(max, (C|all, Attribute, _, ID))
% default(attr, (C|all, Attribute, Value, ID))
% default(negattr, (C|all, Attribute, Value, ID))
% default(le, (C|all, Attribute, Value, ID))
% default(ge, (C|all, Attribute, Value, ID))
% default(comp, (C, _, _, ID))
% default(negcomp, (C, _, _, ID))

% Checks if the default is in conflict with a preference
defaultCheck(T, (C, A, V, ID)) :- default(T, (C, A, V, ID)), not prefer(_, (C, A, _, _)).
% Special cases for comp and negcomp, since they do not use 'Attribute'
defaultCheck(negcomp, (C, A, V, ID)) :- default(negcomp, (C, A, V, ID)), not prefer(_, (C, _, _, _)). % If there is any preference for a component, negcomp will be disabled
defaultCheck(comp, (C, A, V, ID)) :- default(comp, (C, A, V, ID)), not prefer(negcomp, (C, _, _, _)). % If there is a preference against a component, comp will be disabled


% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more answers on the pareto front
#preference(weightDefault(ID), less(weight)) 
{
    S, A, C :: assign(C, A, S), default(min, (all, A, V, ID));
    -S, A, C :: assign(C, A, S), default(max, (all, A, V, ID));
    S, A, C :: assign(C, A, S), default(min, (C, A, V, ID));
    -S, A, C :: assign(C, A, S), default(max, (C, A, V, ID))
} : defaultCheck((min;max), (_, _, _, ID)).


% For Less/Greater on all components the total is calculated seperately
total(A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (all, A, _, _)).
#preference(boundryDefault(ID), less(weight))
{
    T-X, A :: total(A, T), default(le, (all, A, X, ID)), T >= X;
    X-T, A :: total(A, T), default(ge, (all, A, X, ID)), T <= X;
    T-X, A, C :: total(A, T), default(le, (C, A, X, ID)), T >= X;
    X-T, A, C :: total(A, T), default(ge, (C, A, X, ID)), T <= X
} : defaultCheck((ge;le), (_, _, _, ID)).


% Prefering or disprefering certain components
#preference(compDefault(ID), less(weight))
{
	-1, C :: component(C), domain(C, A, V), default(comp, (C, A, V, ID));
	-1, C :: not component(C), domain(C, A, V), default(negcomp, (C, A, V, ID))
} : default((comp;negcomp), (_, _, _, ID)).


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attrDefault(ID), less(weight))
{    
    -1, C, A, V :: assign(C, A, V) , domain(C, A, V), default(attr, (C, A, V, ID));
    -1, C, A, V :: assign(C, A, V) , domain(C, A, V), default(attr, (all, A, V, ID));
    -1, C, A, V :: not assign(C, A, V) , domain(C, A, V), default(negattr, (C, A, V, ID));
    -1, C, A, V :: not assign(C, A, V) , domain(C, A, V), default(negattr, (all, A, V, ID))
} : default((attr;negattr), (_, _, _, ID)).

% Pareto preference to list the pareto front for the given preferences
#preference(defaults, pareto) {**boundryDefault(X); **attrDefault(X); **weightDefault(X); **compDefault(X)}.

