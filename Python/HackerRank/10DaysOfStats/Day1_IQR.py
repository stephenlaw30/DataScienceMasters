l = int(input())
x = input() #6 12 8 10 20 16
w = input() #5 4 3 2 1 5

# convert input to INT's
x = [int(x) for x in x.split()] 
w = [int(x) for x in w.split()]

# empty list
z = [];

# create data set
for i in range(0,len(x)):
    
    #replicate the item in 6 by the same-indexed number in w
    z.append([x[i]]*w[i])
    
    # flatten list of lists into 1 list (for each sublist w/in z, and for each item w/in the sublist, append to flattened list)
    flat_list = [i for sublist in z for i in sublist]

#print(flat_list)

x = sorted(flat_list)
n = len(x)

# If number of elements in array is odd
if n % 2 != 0:
  
  # q2/median is the middle element
  q2 = x[(n-1)//2]
  
  # get index to split array down middle
  splitIndex = (n+1)/2;
  
  # get q1 from 1st half of array
  firstHalf = x[:splitIndex]
  m = len(firstHalf)

  if m % 2 != 0:
    q1 = firstHalf[(m-1)//2]
  else:
    q1 = ((firstHalf[(m//2)-1])+(firstHalf[(m//2)]))/2;

  # get q3 from 2nd half of array
  secondHalf = x[splitIndex+1:]
  o = len(secondHalf)

  if o % 2 != 0:
    q3 = secondHalf[(o-1)//2]
  else:
    q3 = ((secondHalf[(o//2)-1])+(secondHalf[(o//2)]))/2;  

# If number of elements in array is even
else:
  
  # split array into 2 equal halves
  splitIndex = n//2;

  # get q1 from 1st half of array
  firstHalf = x[:splitIndex]
  m = len(firstHalf)

  if m % 2 != 0:
    q1 = firstHalf[(m-1)//2]
  else:
    q1 = ((firstHalf[(m//2)-1])+(firstHalf[(m//2)]))/2;

  # get q3 from 2nd half of array
  secondHalf = x[splitIndex:]
  o = len(secondHalf)

  if o % 2 != 0:
    q3 = secondHalf[(o-1)/2]
  else:
    q3 = ((secondHalf[(o//2)-1])+(secondHalf[(o//2)]))/2;  

print(q3)
print(q1)
iqr = q3 - q1
print(iqr)
  