#variable = [row1.1 row 1.2; row 2.1 row 2.2]

#create vector of numbers from 1 to 2 stepping by 0.1
[1:0.1:2]

#matrix of ones --> 2x3
ones(2,3)

#matrix of zeroes --> 1x3
zeros(1,3)

#matrix of random #'s between 0-1 (uniform distribution)
rand(4,4)

#matrix of 2's
2*ones(4,4)

#matrix of 5's
5*ones(2,2)

#matrix of random #'s between 0-1 (gaussian/normal random distribution)
# mean = 0, SD = 1
randn(4,4)

#create histogram of vector of 10k random #'s
hist(-6 + sqrt(10)*randn(1,10000))

#more bins
hist(-6 + sqrt(10)*randn(1,10000),50)

#4*4 identity matrix
eye(4)

#Help function
help eye
help hist