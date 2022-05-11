% Again, the user likes the first solution. They decide to check out options for a phone holder. At the same time, now that everything is the way the user wants it to, they want to check for a cheaper solution and check a "lowest price" option.

%The preference for the lowest price is performed last as it is very restrictive and will often reduce the number of available options for following preferences severely. Additionally, the GE preference on the price is removed, as it would interfere with the minimization of the price.


prefer(comp, (phone_holder, 0, 0), (120,20)).

prefer(comp, (basket, 0, 0), (110, 20)).
prefer(comp, (stand, 0, 0), (110, 20)).
prefer(negcomp, (phone_holder, 0, 0), (110, 20)).
prefer(negcomp, (bottle_holder, 0, 0), (110, 20)).
prefer(negcomp, (seat_cover, 0, 0), (110, 20)).

prefer(min, (all, price, 339), (90, 20)).


prefer(attr, (frame,material,carbon_fiber),(50, 20)).
prefer(attr, (front_wheel,material,aluminium),(60, 20)).
prefer(attr, (front_wheel,size,26),(60, 20)).
prefer(attr, (rear_wheel,material,aluminium),(60, 20)).
prefer(attr, (rear_wheel,size,26),(60, 20)).
prefer(attr, (basket,material,rattan),(30, 20)).
prefer(attr, (stand,height,15),(30, 20)).

prefer(min, (all, price, 0), (1, 1)).
