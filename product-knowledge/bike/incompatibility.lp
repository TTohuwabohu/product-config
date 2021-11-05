incompatible_com_pv(basket,(bike,type,mountain_bike)).
incompatible_com_pv(basket,(frame,type,f2)).
incompatible_pv_pv((frame,type,f1), (bike,type,mountain_bike)). 
incompatible_pv_pv((frame,type,f3), (bike,type,mountain_bike)). 

incompatible_pv_pv((front_wheel,size,26),(rear_wheel,size,28)).
incompatible_pv_pv((front_wheel,size,28),(rear_wheel,size,26)).

incompatible_pv_pv((frame,type,f1),(cassette,type,c1)).
incompatible_pv_pv((frame,type,f3),(cassette,type,c2)).

incompatible_pv_pv((saddle,type,s1),(seat_cover,type,sc2)).
incompatible_pv_pv((saddle,type,s2),(seat_cover,type,sc1)).