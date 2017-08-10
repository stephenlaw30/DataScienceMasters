function plotData(x, y)
%PLOTDATA Plots the data points x and y into a new figure 
%   PLOTDATA(x,y) plots the data points and gives the figure axes labels of
%   population and profit.

figure; % open a new figure window

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the training data into a figure using the 
%               "figure" and "plot" commands. Set the axes labels using
%               the "xlabel" and "ylabel" commands. Assume the 
%               population and revenue data have been passed in
%               as the x and y arguments of this function.
%
% Hint: You can use the 'rx' option with plot to have the markers
%       appear as red crosses. Furthermore, you can make the
%       markers larger by using plot(..., 'rx', 'MarkerSize', 10);

% Suppose you are the CEO of a restaurant franchise and are considering diﬀerent cities for opening a new outlet. 
% The chain already has trucks in various cities and you have data for proﬁts and populations from the cities.
% You would like to use this data to help you select which city to expand to next. 

%% LOAD IN DATA
%data = load('ex1data1.txt')

%% SEPERATE PREDICTOR FROM OUTCOME
%X = data(:,1);
%y = data(:,2);

%% STORE # OF DATA POINTS

%m = length(y);

%% CREATE SCATTERPLOT OF DATA OF RED CROSSES OF SIZE 10
plot(x, y, 'rx', 'MarkerSize', 10);
ylabel('Profit in $10,000s')
xlabel('Population of City in 10,000s')

% ============================================================

end
