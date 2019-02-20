function dx = stateEquations_train(t,x)
%% Global Variables
global n;
global m;
global tables_struct;
global y;
global time;

%% Measuring input - output
u = sin(t) + 0.5*cos(2*t) + 2*cos(3*t) + 1.5*sin(5*t)+ cos(7*t);
step = time(2);
y_curr = y(floor(t/step+1));
beta = 0.5;

%% Calculatining phi vector
dx = [];        phi_vector = [];

curr_x_1 = x(1:n);
A = tables_struct(1).A;
B = tables_struct(1).B;
C = tables_struct(1).C;
D = tables_struct(1).D;
curr_dx_1 = A*curr_x_1 + B*y_curr;
dx = [dx; curr_dx_1];
phi_vector = [phi_vector; C*curr_x_1 + D*y_curr];


curr_x_2 = x(n+1:2*n);
A = tables_struct(2).A;
B = tables_struct(2).B;
C = tables_struct(2).C;
D = tables_struct(2).D;
curr_dx_2 = A*curr_x_2+ B*u;
phi_vector = [phi_vector; C*curr_x_2 + D*u];
dx = [dx; curr_dx_2];


%% Theta Vector - Estimation - error
theta_vector = x(2*n+1:2*n+n+m+1);
y_hat = (theta_vector')*phi_vector;
error = y_curr - y_hat;

%% P matrix - gradient of theta (Least squares)

P = reshape(x(2*n+n+m+2:end),n+m+1,n+m+1);
grad_p = beta*P - P*phi_vector*(phi_vector')*P;
grad_theta = P*error*phi_vector;

dx = [dx; grad_theta; grad_p(:)];

end