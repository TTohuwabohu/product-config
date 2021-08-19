%preferuirement for minimizing an attribute
%prefer(component|all, attribute, min|max|Value, priority)
%prefer(front_brake, price, min, 1).
prefer(all, price, min, 1).
%prefer(all, price, le, 50, 1).
prefer(bell, color, silver, 2).


% min/max over all components
#minimize{S@P, A, C : assign(C, A, S), prefer(all, A, min, P)}.
#maximize{S@P, A, C : assign(C, A, S), prefer(all, A, max, P)}.

% min/max over specific component
#minimize{S@P, A, C : assign(C, A, S), prefer(C, A, min, P)}.
#maximize{S@P, A, C : assign(C, A, S), prefer(C, A, max, P)}.

% prefer specific attribute
% note that this usually needs a higher priority than min/max over numeric values to have an effect
#maximize{1@P, V, A, C : assign(C, A, V), prefer(C, A, V, P)}.

% ge/le ?
% need to fix, doesn't actually check ge/le for the total price, only for every single component individually
#minimize{S-X@P, A, C : assign(C, A, S), prefer(all, A, le, X, P), S >= X}.
#minimize{S-X@P, A, C : assign(C, A, S), prefer(all, A, ge, X, P), S <= X}.





% Ideas for preferences:
% min/max over value on all/single components
% keep values in a boundary
% prefer specific attributes like color
% prefer attributes/component if other attributes/components exist





