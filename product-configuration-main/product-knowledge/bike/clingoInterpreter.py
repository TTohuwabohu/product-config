from io import StringIO


def clingoInterpreter(clingoString : str):
	clingoString = str(clingoString)
	clingoString = clingoString.replace(r'\r\n', '\r\n')
	print(clingoString)
		