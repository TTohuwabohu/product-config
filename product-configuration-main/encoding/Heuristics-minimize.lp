%requirement for minimizing an attribute
%req(component|all, attribute, min|max|Value)
%req(front_brake, price, min, 1).
req(all, price, min, 1).
%req(all, price, le, 50, 1).
req(bell, color, silver, 2).


% min/max over all components
#minimize{S@P, A, C : assign(C, A, S), req(all, A, min, P)}.
#maximize{S@P, A, C : assign(C, A, S), req(all, A, max, P)}.

% min/max over specific component
#minimize{S@P, A, C : assign(C, A, S), req(C, A, min, P)}.
#maximize{S@P, A, C : assign(C, A, S), req(C, A, max, P)}.

% prefer specific attribute
#maximize{1@P, V, A, C : assign(C, A, V), req(C, A, V, P)}.

% ge/le ?
#minimize{S-X@P, A, C : assign(C, A, S), req(all, A, le, X, P), S >= X}.
#minimize{S-X@P, A, C : assign(C, A, S), req(all, A, ge, X, P), S <= X}.






% min/max over value on all/single components
% prefer attributes like color
% prefer attributes/component if other attributes/components exist

