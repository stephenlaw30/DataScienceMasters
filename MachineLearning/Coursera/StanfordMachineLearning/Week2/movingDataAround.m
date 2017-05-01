A = [1 2; 3 4; 5 6];

#get matrix dims via a 1*2 matrix (rows, cols)
size(A)

#get just 1 dim (rows)
size(A,1) #get just 1st dim (rows)
size(A,2) #get just 2nd dim (cols)

v = [1 2 3 4]
length(v) #get length of longest dimension
length(A) #get 3 b/c 3 > 2 --> 3 is largest dim

#get current dir
pwd
#change dir
cd 'C:\user\desktop'
#see files in current dir
ls
#load in a file
load featuresX.dat
load('featuresX.dat')

#see variables in workspace/memory
who
#get more detailed view (size of each variabelin matrix, memory, class
whos

#clear 1 variable
clear featuresX
#clear ALl vars
clear

#save variable "v" to disk in a file "hello.mat" in a compressed, binary format
save hello.mat v;
#save data im human-readable format
save hello.txt v -ascii 

#get 3rd row, 2nd  col value of matrix
A(3,2)
A(2,:) #get all from 2nd row
A(:,2) #get all from 2nd col

#get all elements from 1st and 3rd row and ALL cols
A([1 3], :)

#replace values in 2nd col
A(:,2) = [10; 11; 12]

#Add 3rd col
A = [A, [13; 14; 15]]

#put all elements of A into single col vector
A(:)

#concatenate matrix A w/ matrix B
C = [A B]
 

