#!/usr/bin/env python
"""
Your task is as follows:
- read the provided Excel file
- find and return the min, max and average values for the COAST region
- find and return the time value for the min and max entries
- the time values should be returned as Python tuples

Please see the test function for the expected return format
"""
import xlrd
from zipfile import ZipFile
datafile = "2013_ERCOT_Hourly_Load_Data.xls"

def open_zip(datafile):
    with ZipFile('{0}.zip'.format(datafile), 'r') as myzip:
        myzip.extractall()

def parse_file(datafile):
    workbook = xlrd.open_workbook(datafile)
    sheet = workbook.sheet_by_index(0)
	
	## intialize lists to hold column values
    coast = []
    times = []
	
	data = [[sheet.cell_value(r, col)
		for col in range(sheet.ncols)]
			for r in range(sheet.nrows)]
	
	## get all values in column 2 [COAST] starting at row below header up tp + including last row
	cv = sheet.col_values(1, start_rowx = 1, end_rowx = None)
	minval = min(cv)
	maxval = max(cv)
	avgvalue = sum(cv)/float(len(cv))

	
	## get position of those min + max values
	## need "+ 1" b/c our data starts at row 1 (start_rowx = 1)
	minpos = cv.index(minval) + 1 
	maxpos = cv.index(maxval) + 1
	
	maxtime = sheet.cell_value(maxpos,0)
	mintime = sheet.cell_value(minpos,0)
	realmaxtime = xlrd.xldate_as_tuple(maxtime,0)
	realmintime = xlrd.xldate_as_tuple(mintime,0)
    
    ## constraints
    data = {
            'maxtime': realmaxtime
            'maxvalue': maxval,
            'mintime': realmintime,
            'minvalue': minval,
            'avgcoast': avgvalue
    }

    return data

def test():
    open_zip(datafile)
    data = parse_file(datafile)

    assert data['maxtime'] == (2013, 8, 13, 17, 0, 0)
    assert round(data['maxvalue'], 10) == round(18779.02551, 10)

test()

data = parse_file(datafile)
from pprint import pprint
pprint(data)