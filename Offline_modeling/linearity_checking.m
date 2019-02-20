%% Togkousidis Anastasis
% AEM: 8920
%% ========== Part 1: Initialization ======================================
clc; clear all; 

%% ========== Part 2: Linearity Checking ==================================
t=0:0.0001:10;
[u1, u2, u3, a, b] = random_inputs(t);

y1 = out(t,u1);
y2 = out(t,u2);
y3 = out(t,u3);

figure;
plot(t,y3,t,(a*y1+b*y2));
title('Linearity checking');
legend('y','ay_1 + by_2');
xlabel('Time');
