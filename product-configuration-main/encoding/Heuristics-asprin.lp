% price calculation for checking the impact of preferences
price(T) :- #sum{V, C : assign(C, price, V)} = T.
#show price/1.

% preferuirement for minimizing an attribute
% Note that priority is not used in asprin but it could be used as a factor in weight preferences to increase priority
% prefer(component|all, attribute, min|max|Value, priority)
prefer(front_brake, price, max, 1).
prefer(all, price, min, 1).
%prefer(all, price, le, 50, 1).
prefer(bell, color, black, 1).

prefer(phone_holder, type, ph1).



% ignore any unnecessary components
%#preference(p1,subset){ assign(C,A,V) : domain(C,A,V) }.
#preference(p1, more(cardinality)) { assign(C, A, V) : domain(C, A, V)}.
%#optimize(p1).

% Idea: If it is a city bike, try to add a phone holder
% can't use non-domain atoms on the condition in p2
pref(city_bike, phone_holder). 
pref(phone_holder).

% "a << not a" seems to only work with the cp type
% --meta=no flag is necessary, need to check what that is but it doesn't seem to have an impact on performance
#preference(p2, cp) {assign(C, type, X) >> not assign(C, type, X) : pref(C), domain(C, type, X)}.
%#preference(p2, cp) {assign(C1, type, X) >> not assign(C1, type, X) : pref(C1, C2), assign(A, B, C1), domain(C2, type, X)}.


% The weight preferences could all be in the same preference statement if they are comparable
% putting them in seperate statements would result in more answers on the pareto front
% Can preferences be generated like "#preference(prefer(A,B,C), less(weight)) {...}." ?
#preference(min, less(weight)) 
{
	S*P, A, C :: assign(C, A, S), prefer(all, A, min, P); % #minimize statements
	-S*P, A, C :: assign(C, A, S), prefer(all, A, max, P); % #maximize statements
	S*P, A, C :: assign(C, A, S), prefer(C, A, min, P);
	-S*P, A, C :: assign(C, A, S), prefer(C, A, max, P)
}.


% prefer specific attributes
% aso and poset both work, but exact results / order of answers are different
#preference(p3, aso)
{	
	assign(C, A, V) : domain(C, A, V), prefer(C, A, V, P)
}.

% pareto preference is necessary to optimize over multiple preferences
#preference(all, pareto) {**p3}.
#optimize(all).


