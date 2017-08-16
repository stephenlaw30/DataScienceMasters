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
	
	## looping through columns and rows, store all col 1 values in 'times' and all col 2 values in 'coast'
	## ignore header row (row > 0)
    for row in range(sheet.nrows):
        for col in range(sheet.ncols):
            if row > 0:
                if col == 1:
                    coast.append(sheet.cell_value(row,col))
                elif col == 0:
                    times.append(sheet.cell_value(row,col))
    
    ## constraints
    data = {
            'maxtime': (0, 0, 0, 0, 0, 0),
            'maxvalue': 0,
            'mintime': (0, 0, 0, 0, 0, 0),
            'minvalue': 0,
            'avgcoast': 0
    }
    
    ## add min, max, avg coast values and convert row's times into date format with xldate_as_tuple()
    data['maxvalue'] = max(coast)
    data['minvalue'] = min(coast)
    data['avgcoast'] = sum(coast)/len(coast)
    data['maxtime'] = xlrd.xldate_as_tuple(times[coast.index(max(coast))], 0)
    data['mintime'] = xlrd.xldate_as_tuple(times[coast.index(min(coast))], 0)
    
    #print(data)

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