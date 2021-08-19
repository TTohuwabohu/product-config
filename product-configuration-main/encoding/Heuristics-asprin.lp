
req(phone_holder, type, ph1).



% ignore any unnecessary components
%#preference(p1,subset){ assign(C,A,V) : domain(C,A,V) }.
#preference(p1, more(cardinality)) { assign(C, A, V) : domain(C, A, V)}.
%#optimize(p1).


pref(city_bike, phone_holder). % can't use non-domain atoms but this would require to check assign
pref(phone_holder).
#preference(p2, cp) {assign(C, type, X) >> not assign(C, type, X) : pref(C), domain(C, type, X)}.
%#preference(p2, cp) {assign(C1, type, X) >> not assign(C1, type, X) : pref(C1, C2), assign(A, B, C1), domain(C2, type, X)}.



#preference(min, less(weight)) 
{
	S, A, C :: assign(C, A, S), req(all, A, min, P); % #minimize statements
	-S, A, C :: assign(C, A, S), req(all, A, max, P); % #maximize statements
	S, A, C : assign(C, A, S), req(C, A, min, P);
	-S, A, C : assign(C, A, S), req(C, A, max, P)
	1*P, V, A, C :: assign(C, A, V), req(C, A, V, P)
}.

#preference(all, pareto) {**p2; **min}.
#optimize(all).

price(T) :- #sum{V, C : assign(C, price, V)} = T.
#show price/1.

%requirement for minimizing an attribute
%req(component|all, attribute, min|max|Value)
req(front_brake, price, max, 1).
req(all, price, min, 1).
%req(all, price, le, 50, 1).
req(bell, color, black, 1).




% min/max over all components
%#minimize{S@P, A, C : assign(C, A, S), req(all, A, min, P)}.
%#maximize{S@P, A, C : assign(C, A, S), req(all, A, max, P)}.

% min/max over specific component
%#minimize{S@P, A, C : assign(C, A, S), req(C, A, min, P)}.
%#maximize{S@P, A, C : assign(C, A, S), req(C, A, max, P)}.

% prefer specific attribute
%#maximize{1@P, V, A, C : assign(C, A, V), req(C, A, V, P)}.

% ge/le ?
%#minimize{S-X@P, A, C : assign(C, A, S), req(all, A, le, X, P), S >= X}.
%#minimize{S-X@P, A, C : assign(C, A, S), req(all, A, ge, X, P), S <= X}.
