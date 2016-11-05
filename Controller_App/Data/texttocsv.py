import csv
import sys

#####################################################
# Author: Neladri Bose
# Date: 10/30/2016
# Purpose: Converts comma delimited text files to csv
#####################################################

def convertText():
	
	if len(sys.argv) > 2: # Checks if output name is given
		text_filename = sys.argv[1]
		csv_filename = sys.argv[2] + ".csv"
	else:
		text_filename = sys.argv[1]
		csv_filename = sys.argv[1]
		# Same named output as input text file
		csv_filename = csv_filename.replace('.txt','.csv')
	
	input_text = csv.reader(open(text_filename, 'rb'), delimiter = ',')
	output_csv = csv.writer(open(csv_filename, 'wb'), delimiter = ',')
	output_csv.writerows(input_text)

if __name__ == '__main__':
	convertText() # calls function to begin parsing