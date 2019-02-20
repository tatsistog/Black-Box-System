function dx = stateEquations_offline (t,x)
%% Input
u = sin(t)+0.1*cos(2*t);

global a1;
global a2;
global a3;

global b0;
global b1;
global b2;

b_1 = b0;
b_2 = b1 - a1*b_1;
b_3 = b2 - a1*b_2 - a2*b_1;

%% System
dx1 = x(2) + b_1*u;
dx2 = x(3) + b_2*u;
dx3 = -a3*x(1) - a2*x(2) - a1*x(3) + b_3*u;

dx = [dx1; dx2; dx3];

end