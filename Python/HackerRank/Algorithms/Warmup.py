## Warm-up
def solveMeFirst(a,b):
   # Hint: Type return a+b below 
    return a+b

num1 = int(input())
num2 = int(input())
res = solveMeFirst(num1,num2)
print(res)

return a+b

## Simple Array Sum as single INT
#!/bin/python3

import sys

def simpleArraySum(n, ar):
    # Complete this function
    total = 0;
    for i in range(0,n):
        total += ar[i]
    return total

n = int(input().strip())
ar = list(map(int, input().strip().split(' ')))
result = simpleArraySum(n, ar)
print(result)

