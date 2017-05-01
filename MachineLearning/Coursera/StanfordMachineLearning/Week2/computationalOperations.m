#3 * 2 matrix --> row 1; row 2; row 3;
A = [1 2; 3 4; 5 6];
B = [11 12; 13 14; 15 16];
C = [1 1; 2 2;];

#3x2 matrix times 2x2 matrix = 3x2 matrix
A * C
#multiply each element of A by its corresponding element in B
A .* B
#element-wise squaring of A
A .^ 2

v = [1; 2; 3];
#get element-wise recipricol
1 ./ v
1 /. A

#element-wise functions
log(v)
exp(A)
abs([=1; 2; -3])
-v #same as -1*v 

#increase each element of v by 1 via a 3x1 vector made of ones
v + ones(length(v),1)

#a transpose
A'
(A')' #original vector

max(A)
min(A)

#get max value of a vector and its index
a = [1 15 2 0.5];
[val, ind] = max(a)

#max on matrix gives max column-wise value
max(A)

#element-wise logic
a > 3
#get index of elements = TRUE
find(a < 3)

#use magic() to return a magic square matrix = all rows, cols, + diagonals add
 # up to same thing
E = magic(3)

#find the row + col index of values w/in magic square of values > 7
[r,c] = find(E > 7)
E(3,2)

#add all elements of vector
sum(a)  
#product of all elements of vector
prod(a)
#round all elements
floor(a)
ceil(a)

#element-wise max of 2 random 3x3 matrices
F = rand(3)
G = rand(3)
max(F,G)

#find COLUMN-wise max = max value in each col (1st dimension) = 1*3 vector
max(E,[],1);
#find row-wise max = max value in each row (2nd dimension) = 3*1 vector
max(E,[],2);

#max value of entire matrix by via double max() or turning it into a vector
max(max(A))
max(A(:))

M = magic(9)
#column sums
sum(M,1)
#row sums
sum(M,2)
#diagonal sums via identity matrix via element-wise multiplication (.*)
M .* eye(9)
sum(sum(M .* eye(9)))

#opposite diagonal
flipud(eye(9))

#invert matrix
pinv(A)
#make identity matrix via the inverted matrix
floor(A * pinv(A))