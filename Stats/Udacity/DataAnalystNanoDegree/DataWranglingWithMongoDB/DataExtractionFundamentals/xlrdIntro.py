#!/usr/bin/env python
"""
Your task is as follows:
- read the provided Excel file
- find and return the min, max and average values for the COAST region
- find and return the time value for the min and max entries
- the time values should be returned as Python tuples

Please see the test function for the expected return format

"""

###*** xlrd module allows us to read in Excel files (.xls or .xlsx formats) and work w/ it in any way we need to
###*** xlwt module allows us to create Excel files
import xlrd
from zipfile import ZipFile
datafile =('2013_ERCOT_Hourly_Load_Data.xls')

def open_zip(datafile):
	## open a ZIP file with the name = given data file name and extract all contents
    with ZipFile('{0}.zip'.format(datafile), 'r') as myzip:
        myzip.extractall()


def parse_file(datafile):
	## open workbook and specify sheet to work on
    workbook = xlrd.open_workbook(datafile)
    sheet = workbook.sheet_by_index(0)

    ## loop through the rows + columns in current sheet + read this data into list sheet_data
    sheet_data = [[sheet.cell_value(r, col) 
		for col in range(sheet.ncols)]
			for r in range(sheet.nrows)]
	
	## print our values in row 3 col 2
    print('\nList Comprehension')
    print('sheet_data[3][2]:')
    print(sheet_data[3][2])
	
	##Loop through row and cols + once we hit row 50, print out all values in that row (50)
    print('\nCells in a nested loop')
    for row in range(sheet.nrows):
        for col in range(sheet.ncols):
            if row == 50:
                print(sheet.cell_value(row,col))

    ### other useful methods:
    print('\nROWS, COLUMNS, and CELLS:')
    print('Number of rows in the sheet:')
    print(sheet.nrows)
    print('\nType of data in cell (row 3, col 2)  [given as INT -> check in xlrd documentation]:'), 
    print(sheet.cell_type(3, 2))
    print('\nValue in cell (row 3, col 2):'), 
    print(sheet.cell_value(3, 2))
    print('\nGet a slice of values in column 3, from rows 1-4, not including row 4:')
    print(sheet.col_values(3, start_rowx=1, end_rowx=4))

    print('\nDATES:')
    print('Type of data in cell (row 1, col 0):')
    print(sheet.cell_type(1, 0))
	
	# convert old excel format from floating point numbers into date via xl_date_as_tuple()
    exceltime = sheet.cell_value(1, 0)
    print('\nTime in Excel format:')
    print(exceltime)
    print('\nConvert time to a Python datetime tuple, from the Excel float:')
    print(xlrd.xldate_as_tuple(exceltime, 0))
    
open_zip(datafile)
parse_file(datafile)