function plotspectrum(y, u, t, dt)
%% Plotting spectrum of input and output

Fs = 1/dt;
N = size(t,2);
Y = fftshift(fft(y));
U = fftshift(fft(u));
dF = Fs/N;
f = -Fs/2:dF:Fs/2-dF;           % hertz

figure;
subplot(3,1,1);
plot(t,u);
xlabel('time');
ylabel('Value of u(t)');
title('Input over time - delta dirac');


subplot(3,1,2);
plot(f,abs(U)/N); 
xlim([-10,10]);
xlabel('f (Hz)');
ylabel('|U(f)|');

subplot(3,1,3);
plot(f,abs(Y)/N); 
title('Impulse response of system');
xlim([-10,10]);
xlabel('f (Hz)');
ylabel('|H(f)|');

end