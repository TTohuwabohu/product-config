import argparse
import sys
import clingo
import argparse
import subprocess
import asprin
from AddInput import addInput
from clingoInterpreter import clingoInterpreter


def run():
	inputList = []
	mainloop = 'y'
	#cleaner = open('input.lp', 'r+')
	#cleaner.truncate(0)
	#cleaner.close()
	while (mainloop == 'y'):
		
		addInput(inputList)
			
		PreferenceFile = open('users/UserPreference.lp', 'a')
		RequirementFile = open("users/UserRequirement.lp", 'a')
		for constraint in inputList:
			if (constraint.type == "req"):
				RequirementFile.write(constraint.literal + "(" + constraint.type + ",(" + constraint.component + "," + constraint.attribute + "," + constraint.value + ")).")
			else:
				PreferenceFile.write(constraint.literal + "(" + constraint.type + ",(" + constraint.component + "," + constraint.attribute + "," + constraint.value + ", " + constraint.ID + ")).")
		PreferenceFile.close()
		RequirementFile.close()
		teststr = "prefer(max, (all, price, 0, 1))."
			
		solver = subprocess.Popen(["asprin", "show.lp", "users/UserPreference.lp", "users/UserRequirement.lp", "users/defaults.lp", "5"], stdout=subprocess.PIPE)
		out, err = solver.communicate()
		
		result = clingoInterpreter(out)
		
		mainloop = input("input more preferences and requirements? y/n")
		
	

if __name__ == "__main__":
	run()
	
