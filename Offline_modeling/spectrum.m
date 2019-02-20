clc;
clear;
dt = 0.0001;
t = -20:dt:20;
u = 100000*sinc(10000000*t);
y = out(t,u);
plotspectrum(y, u, t, dt);
