function [theta, error] = normalEqn(X, y)
%% NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.
[m, n] = size(X);
theta = ((y') * X)/((X')*X);
theta = theta' ; 

error = (1/(2*m))*sum((y - X*theta).^2);
end
