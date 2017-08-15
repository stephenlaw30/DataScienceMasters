# Enter your code here. Read input from STDIN. Print output to STDOUT
import numpy as np
from scipy import stats

n = int(input())

## for each int element from the STDIN, split it and convert to and INT
a = [int(x) for x in input().split()] 

## get mean + median w/ Numpy, Mode w/ stats from scipy
print(np.mean(a))
print(np.median(a))
print(int(stats.mode(a)[0]))
