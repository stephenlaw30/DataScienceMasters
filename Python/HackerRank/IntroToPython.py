'''---------HACKERRANK-------------

---------PYTHON - 1 = INTRO-----------'''

#1
if __name__ == '__main__':
    print "Hello, World!"
	
#2 - Reading Raw Input from STDIN'''
def read():
    s = input(); #python 2 = raw_input()
    return s
	
if __name__ == '__main__':
    my_str = read()
    print my_str
	
	
#3 - If-else
if __name__ == '__main__':
    n = int(input())
    
	#if odd
    if n % 2 != 0:
        print('Weird')
	#if in [2,5] inclusive
    elif 2 <= n <= 5:
        print('Not Weird')
    elif 6 <= n <= 20:
        print('Weird')
    elif n >= 20:
        print('Not Weird')
		
#4 - Arithmetic
if __name__ == '__main__':
    a = int(input())
    b = int(input())
    
    print(a+b);
    
    print(a-b);
    
    print(a*b);
	
#5 - division
from __future__ import division
if __name__ == '__main__':
    a = int(raw_input());
    b = int(raw_input());
    
    print(a//b); #integer division --> rounded to INT
    print(a/b); #float division

#6 - Loops
'''Read an integer N + for all non-negative integers i < N , print, i^2 See the sample for details.'''
if __name__ == '__main__':
    n = int(input())
	
    for i in range(0,n):
        #if i < n:
        print(i**2)
		
#7 - Functions
'''We add a Leap Day on February 29, almost every 4 years. In the Gregorian calendarcriteria must be taken into account to identify leap years:
	- The year can be evenly divided by 4, unless;
	- The year can be evenly divided by 100, it is NOT a leap year, unless;
	- The year is also evenly divisible by 400. Then it is a leap year.

This means that in the Gregorian calendar, 2000 and 2400 are leap years, while 1800, 1900, 2100, 2200, 2300 and 2500 are NOT leap years.'''
def is_leap(year):
    leap = False
    
    # Write your logic here
    if (year % 4) == 0:
        if year % 100 == 0:
            if year % 400 == 0:
                leap = True;
            else:
                leap = False;
        else:
            leap = True;
    
    return leap

year = int(input())
print(is_leap(year))

#8 - Print
if __name__ == '__main__':
    n = int(input())
    
    for i in range(1,n+1):
        print(i,end="") #prints each element in succession on 1 line w/ no spaces between
