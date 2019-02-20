function [u1,u2,u3, a, b] = random_inputs(t)
%% This function creates random functions sins and cosins to test whether
% the system is a linear one

amp_1 = rand;
amp_2 = rand;
f_1 = 10*rand;
f_2 = 10*rand;
phase_1 = 2*pi*rand;
phase_2 = 2*pi*rand;


a = 10*rand;
b = 10*rand;

m = length(t);
u1 = zeros(m,1);
u2 = zeros(m,1);

for i = 1:1:m
    u1(i) = amp_1 * sin(f_1*t(i) + phase_1);
    u2(i) = amp_2 * sin(f_2*t(i) + phase_2);
end

u3 = a*u1 + b*u2;

end