%The user wants a bike with a basket. A basket also requires a stand. The user says that they do not want any other optional components and sets their price limit to 400. Since the user is clearly willing to pay a certain amount, the seller adds an additional preference as default to keep the price above 360, if possible, in order to increase profits.


prefer(comp, (basket, 0, 0), (110, 20)).
prefer(comp, (stand, 0, 0), (110, 20)).
prefer(negcomp, (phone_holder, 0, 0), (110, 20)).
prefer(negcomp, (bottle_holder, 0, 0), (110, 20)).
prefer(negcomp, (seat_cover, 0, 0), (110, 20)).

prefer(le, (all, price, 400), (90, 20)).
prefer(ge, (all, price, 360), (5,20)).

