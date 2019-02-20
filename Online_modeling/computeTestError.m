function error = computeTestError(y_test,y_hat)

m = length(y_test);
error = (1/(2*m)) * sum((y_test - y_hat).^2);

end