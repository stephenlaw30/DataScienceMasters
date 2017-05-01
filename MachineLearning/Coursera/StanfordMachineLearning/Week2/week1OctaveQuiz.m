#3 * 2 matrix --> row 1; row 2; row 3;
A = [1 2; 3 4; 5 6];
#2 * 3 matrix
B = [1 2 3; 4 5 6]

#valid
A * B;
B' + A;

#invalid
A' * B;
B + A;

C = [16 2 3 13; 5 11 10 8; 9 7 6 12; 4 14 15 1]
C(1:4, 1:2);
C(:, 1:2)