# Read the input DATAFILE line by line, and for 1st 10 lines (not including header) SPLIT each 
# line on "," and for each line, create a dictionary where key = header title of the field, and 
# value = value of that field in the row.

# The function parse_file should return a LIST of dictionaries w/ each data line in the file being 
# a single list entry.

# Field names and values should not contain extra whitespace, like spaces or newline characters (strip())

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
    with open(datafile, "rb") as f:
        ## get the headers by reading 1st line of the file, f (which stops at the newline)
        ## split the headers by comma to be able to use as keys further on
        headers = f.readline().split(',')
        #print(header)
        
        ## initiate counter to only read 1st 10 lines
        counter = 0
        
        ## starting from second line (aftermath of f.readline())...
        for line in f:
            if counter == 10:
                break
            
            ## split current line by comma into seperate elements    
            fields = line.split(',')
        
            ## initialize dictionary
            dictEntry = {}
            
            ## Return an enumerate object (summer winter --> (1, summer), (2, winter)
			## enumerate() gives us an index value and a value for each item in the given list arg
            for i, value in enumerate(fields):
                #print(i, value)
                
                ## for each list of values (line), make the key that header of the same column index
                ## then make the value = the value from the current line's list + remove whitespace
                dictEntry[headers[i].strip()] = value.strip()
            
            ## add dictonary entry (element) into data array, increase counter, move to next line
            data.append(dictEntry)
			counter += 1
            
    return data

def test():
    # a simple test of your implemetation
    datafile = os.path.join(DATADIR, DATAFILE)
    d = parse_file(datafile)
    firstline = {'Title': 'Please Please Me', 'UK Chart Position': '1', 'Label': 'Parlophone(UK)', 'Released': '22 March 1963', 'US Chart Position': '-', 'RIAA Certification': 'Platinum', 'BPI Certification': 'Gold'}
    tenthline = {'Title': '', 'UK Chart Position': '1', 'Label': 'Parlophone(UK)', 'Released': '10 July 1964', 'US Chart Position': '-', 'RIAA Certification': '', 'BPI Certification': 'Gold'}
    #print(d[9])
    assert d[0] == firstline
    assert d[9] == tenthline

test()