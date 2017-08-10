# Read the input DATAFILE line by line, and for 1st 10 lines (not including header) SPLIT each 
# line on "," and for each line, create a dictionary where key = header title of the field, and 
# value = value of that field in the row.

# The function parse_file should return a LIST of dictionaries w/ each data line in the file being 
# a single list entry.

# Field names and values should not contain extra whitespace, like spaces or newline characters (strip())

import os

DATADIR = ""
DATAFILE = "beatles-diskography.csv"

def parse_file(datafile):
    data = []
    with open(datafile, "r") as f:
        for line in f:
            data.append(line.split(','))

    return data
    
datafile = os.path.join(DATADIR, DATAFILE)
print parse_file(datafile)

'''
def test():
    # a simple test of your implemetation
    datafile = os.path.join(DATADIR, DATAFILE)
    d = parse_file(datafile)
    firstline = {'Title': 'Please Please Me', 'UK Chart Position': '1', 'Label': 'Parlophone(UK)', 'Released': '22 March 1963', 'US Chart Position': '-', 'RIAA Certification': 'Platinum', 'BPI Certification': 'Gold'}
    tenthline = {'Title': '', 'UK Chart Position': '1', 'Label': 'Parlophone(UK)', 'Released': '10 July 1964', 'US Chart Position': '-', 'RIAA Certification': '', 'BPI Certification': 'Gold'}

    assert d[0] == firstline
    assert d[9] == tenthline

    
test()'''