% Same structure as prefer:
% default(type, (Component|all, Attribute, Value), (Priority, Weight))


% Checks if the default is in conflict with a preference
defaultCheck(T, (C, A, V), (P, W)) :- default(T, (C, A, V), (P, W)), not prefer(_, (C, A, _), _).
defaultCheck(T, (C, A, V), (P, W)) :- default(T, (C, A, V), (P, W)), not prefer(_, (all, A, _), _).
% Special cases for comp and negcomp, since they do not use 'Attribute'
defaultCheck(negcomp, (C, A, V), (P, W)) :- default(negcomp, (C, A, V), (P, W)), not prefer(_, (C, _, _), _). % If there is any preference for a component, negcomp will be disabled
defaultCheck(comp, (C, A, V), (P, W)) :- default(comp, (C, A, V), (P, W)), not prefer(negcomp, (C, _, _), _). % If there is a preference against a component, comp will be disabled


% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more answers on the pareto front
#preference(weightDefault(P), less(weight)) 
{
    S, A, C :: assign(C, A, S), default(min, (all, A, V), (P, W));
    -S, A, C :: assign(C, A, S), default(max, (all, A, V), (P, W));
    S, A, C :: assign(C, A, S), default(min, (C, A, V), (P, W));
    -S, A, C :: assign(C, A, S), default(max, (C, A, V), (P, W))
} : defaultCheck((min;max), (_, _, _), (P, W)).


% For Less/Greater on all components the total is calculated seperately
total(A, T) :- #sum{V, C : assign(C, A, V)} = T, prefer((ge;le), (all, A, _), _).
#preference(boundryDefault(P), less(weight))
{
	W, A :: total(A, T), default(leR, (all, A, X), (P, W)), T >= X;
	W, A :: total(A, T), default(geR, (all, A, X), (P, W)), T <= X;
	W, A, C :: assign(C, A, T), default(leR, (C, A, X), (P, W)), T >= X;
	W, A, C :: assign(C, A, T), default(geR, (C, A, X), (P, W)), T <= X;
    T-X, A :: total(A, T), default(le, (all, A, X), (P, W)), T >= X;
    X-T, A :: total(A, T), default(ge, (all, A, X), (P, W)), T <= X;
    T-X, A, C :: total(A, T), default(le, (C, A, X), (P, W)), T >= X;
    X-T, A, C :: total(A, T), default(ge, (C, A, X), (P, W)), T <= X
} : defaultCheck((ge;le), (_, _, _), (P, W)).


% Prefering or disprefering certain components
#preference(compDefault(P), less(weight))
{
	-W, C :: component(C), domain(C, A, V), default(comp, (C, A, V), (P, W));
	-W, C :: not component(C), domain(C, A, V), default(negcomp, (C, A, V), (P, W))
} : defaultCheck((comp;negcomp), (_, _, _), (P, _)).


%Prefering or disprefering certain attributes (color, material, ...)
#preference(attrDefault(P), less(weight))
{    
    -W, C, A, V :: assign(C, A, V) , domain(C, A, V), default(attr, (C, A, V), (P, W));
    -W, C, A, V :: assign(C, A, V) , domain(C, A, V), default(attr, (all, A, V), (P, W));
    -W, C, A, V :: not assign(C, A, V) , domain(C, A, V), default(negattr, (C, A, V), (P, W));
    -W, C, A, V :: not assign(C, A, V) , domain(C, A, V), default(negattr, (all, A, V), (P, W))
} : defaultCheck((attr;negattr), (_, _, _), (P, W)).

% Pareto preference to list the pareto front for the given preferences
#preference(defaults, pareto) {**boundryDefault(X); **attrDefault(X); **weightDefault(X); **compDefault(X)}.

