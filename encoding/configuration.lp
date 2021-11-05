%%%%%%%%%%%%%%%%% Assign value from domain to a component property%%%%%%%%%%%%%%%%%%%%%%%%

%Every value from the domain of a component property may be assigned to it 
{assign(Component,Property,Value): domain(Component,Property,Value)}.

%No component property can have more than one value
:- assign(Component,Property,Value1), assign(Component,Property,Value2), Value1 < Value2.

%%%%%%%%%%%%%%%%%%%%%% Component extraction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

component(Component):- assign(Component,Property,Value).

%%%%%%%%%%%%%%%%%%%%%%%%% Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% All the mandatory properties of the component should be assigned
:- component(Component), mandatory_property(Component,Property), not assign(Component,Property,_).

%The component can't have properties of the comp type it is not assigned to
:- assign(Component,type,Comp_Type), assign(Component,Property,Value), Property != type , not property_val(Comp_Type,Property,Value).

%The component has all the property values of the component type it is assigned
:- assign(Component,type,Comp_Type), property_val(Comp_Type,Property,Value), not assign(Component,Property,Value).

%%%%%%%%%%%%%%%%%%%%%%%%%%% Requires %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%A component requires another component
:- require_com_com(Component1,Component2), component(Component1), not component(Component2).

%A component requires another component with certain property value
:- require_com_pv(Component1,(Component2,Property,Value)), component(Component1), not assign(Component2,Property,Value).

%A component  with certain property value requires another component
:- require_pv_com((Component1,Property,Value),Component2), assign(Component1,Property,Value), not component(Component2).

%A component  with certain property value requires another component with certain property value  
:- require_pv_pv((Component1,Property1,Value1),(Component2,Property2,Value2)),
   assign(Component1,Property1,Value1),
   not assign(Component2,Property2,Value2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Incompatability %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%One component is incompatible with another component
:- incompatible_com_com(Component1,Component2), component(Component1), component(Component2).

%One component with certain property value is incompatible with another component 
:- incompatible_com_pv(Component1,(Component2,Property,Value)), component(Component1), assign(Component2,Property,Value).

%One component with certain property value is incompatible with another component with some other property value
:- incompatible_pv_pv((Component1,Property1,Value1),(Component2,Property2,Value2)), 
   assign(Component1,Property1,Value1),
   assign(Component2,Property2,Value2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%% User Req%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A component that user requires has to be present in the configuration
:- user_com(req,Component), not component(Component).

% A component that user doesn't require can't be present in the configuration
:- user_com(nreq,Component), component(Component).

% If a user requires a component with certain property value, then it has to be present in the configuration
:- user_com_pv(req,(Component,Property,Value)), not assign(Component,Property,Value).

% A component with certain property value not required by the user can't be present in the configuration
:- user_com_pv(nreq,(Component,Property,Value)), assign(Component, Property,Value).

