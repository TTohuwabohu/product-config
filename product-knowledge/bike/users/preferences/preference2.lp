% The user likes the first solution that was proposed and wants to see similar solutions. We decide that the material of the frame as well as the size and material of the wheels are the most defining attributes for a bike and create similarity preferences for them. Additionally, since the user specifically requested for a basket (and a stand by extension) we also include similarity preferences for the stand height and the material of the basket as these seem relevant to the user.
% We also readjust the price range. Any solutions within 10% of the reference solution is acceptable.

prefer(comp, (basket, 0, 0), (110, 20)).
prefer(comp, (stand, 0, 0), (110, 20)).
prefer(negcomp, (phone_holder, 0, 0), (110, 20)).
prefer(negcomp, (bottle_holder, 0, 0), (110, 20)).
prefer(negcomp, (seat_cover, 0, 0), (110, 20)).

prefer(le, (all, price, 407), (90, 20)).
prefer(ge, (all, price, 333), (90, 20)).

% Similarity preferences 
prefer(attr, (frame,material,carbon_fiber),(50, 20)).
prefer(attr, (front_wheel,material,aluminium),(60, 20)).
prefer(attr, (front_wheel,size,26),(60, 20)).
prefer(attr, (rear_wheel,material,aluminium),(60, 20)).
prefer(attr, (rear_wheel,size,26),(60, 20)).
prefer(attr, (basket,material,rattan),(30, 20)).
prefer(attr, (stand,height,15),(30, 20)).

