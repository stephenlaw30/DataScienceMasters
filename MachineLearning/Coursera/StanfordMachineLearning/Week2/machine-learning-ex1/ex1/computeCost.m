function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
#%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

%%%%% Initialize some useful values

% number of training examples
  m = length(y); 

#hypothesis predictions for each example/observation
  h = X * theta;

#element wise square errors
  squaredErrors = (h - y).^2;
  sse = sum(squaredErrors);

% You need to return the following variables correctly 
  J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.
% Remember that X and y are *not* scalar values, but matrices whose rows 
%   represent the examples from the training set

  J = (1/(2*m))*sse;
  #J = sum((X*theta - y).^2) / (2 * m);

% =========================================================================

end
