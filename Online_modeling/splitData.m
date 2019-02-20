function [y_train, y_test,u_train, u_test, time_train, time_test] = splitData(y,time,u)

N = 0.7*(length(y)-1);
y_train = y(1:N+1);
time_train = time(1:N+1);
y_test = y(N+2:end);
time_test = time(N+2:end);
u_train = u(1:N+1);
u_test = u(N+2:end);

end