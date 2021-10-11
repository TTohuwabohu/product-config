
from dataclasses import dataclass

@dataclass
class Config:
	literal: str 
	type: str
	component: str
	attribute: str
	value: str
	ID: str


	
def addInput(inputList):
	cont = "y"
	while(cont == "y" or cont == "Y"):
		config = Config("","","","","", "")
		config.literal 			= input("Input literal name")
		config.type 				= input("Type (Pref: min, max, le, ge, attr, comp, ...)")
		config.component 	= input("Component")
		config.attribute 		= input("Attribute")
		config.value 				= input("Value")
		config.ID 					= input("ID")
			
		inputList.append(config)
			
		cont = input("input another requirement or preference? Y/N")
		
		