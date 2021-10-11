prefer(le, (all, price, 400, 1)).
prefer(ge, (all, price, 350, 1)).
prefer(min, (all, size, 0, 1)).

%our answers should not contain the minimum possible price outside of the boundaries, only the minimum possible price inside the boundaries (if a configuration inside the boundaries exists)
