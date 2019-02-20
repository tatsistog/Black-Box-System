function dx = stateEquations_test(t,x)
%% Global Variables11
global n;
global tables_struct;
global y;
global time;


%% Measuring input - output
u = sin(t) + 0.5*cos(2*t) + 2*cos(3*t) + 1.5*sin(5*t)+ cos(7*t);
step = time(2);
y_curr = y(floor(t/step+1));

%% Calculatining phi vector
dx = [];

curr_x_1 = x(1:n);
A = tables_struct(1).A;
B = tables_struct(1).B;
curr_dx_1 = A*curr_x_1 + B*y_curr;
dx = [dx; curr_dx_1];

curr_x_2 = x(n+1:2*n);
A = tables_struct(2).A;
B = tables_struct(2).B;
curr_dx_2 = A*curr_x_2+ B*u;
dx = [dx; curr_dx_2];

end