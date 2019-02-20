%% Togkousidis Anastasis
% AEM: 8920
%% ========== Part 1: Initialization ======================================
clc; clear all; 

%% ========== Part 2: Input - Output ======================================
% In this part I created some functions so as to be able to test
% many input functions, especially sums of sins and cosins

% sincos array: 1 for sin, 0 for cos

dt = 0.00001;
t = (0:dt:10)';
frequencies = [2,5,8];
amps = [2,3,4];
sincos = [0,1,0];

u = createinput(frequencies,amps,sincos,t);
y = out(t,u);

fprintf('Input and output created. Press any key to start training of theta vector. \n');
pause;

%% ========== Part 3: Offline Modeling ====================================
% Deciding the degree of output and input in differential equation, based
% on minimun test error

n_max = 5;
m_max = n_max;


fprintf('Training...... (This may take up to 5 minutes).\n');
training_error_matrix = Inf(n_max, m_max);
test_error_matrix = Inf(n_max, m_max);

figure(1); hold on;
figure(2); hold on;
counter = 1;

for i = 1:1:n_max
    for j = 0:1:i-1
        n = i; m = j;
        [L, ~ ] = stableFilter(i, frequencies);
        zeta_matrix = createmodel(y, u, t, i, j, L);
        [y_train, y_test, zeta_train, zeta_test, time_train, time_test] = splitDadta(y, zeta_matrix, t);
        
        % Training
        [theta, training_error] = normalEqn(zeta_train, y_train);
        y_hat = zeta_train * theta;

        figure(1);
        subplot(3,5,counter);
        plot(time_train(1:length(y_hat)), y_train(1:length(y_hat)) - y_hat);
        title(['n = ', num2str(n),' m = ', num2str(m)]);
        hold on;
        
        % Testing
        y_hat = zeta_test * theta;
        figure(2);
        subplot(3,5,counter);
        plot(time_test, y_test(1:length(y_hat)) - y_hat);
        title(['n = ', num2str(n),' m = ', num2str(m)]);
        hold on;
        
        % Calculating mean square error
        training_error_matrix(i,j+1) = training_error;
        test_error_matrix(i,j+1) = computeTestError(y_test,zeta_test,theta);
        
        counter = counter + 1;
    end
end

figure(1);
suptitle('Training Errors for multiple n, m values.');
figure(2);
suptitle('Test Errors for multiple n, m values.');

error_min = min(test_error_matrix(:));
[row,col] = find(test_error_matrix==error_min);
n = row;
m = col-1;

fprintf('The lowest test error found for n = %d and m = %d. \n',n,m);
fprintf('Press any key to continue.\n');
pause;

%% ======== Part 4: Testing on current input ==============================
fprintf('In this part we re-train theta for optimized n, m in order to take more accurate result.\n');
fprintf('Training......\n');

dt = 0.00001;
t = (0:dt:10)';
frequencies = [2,5,8];
amps = [2,3,4];
sincos = [0,1,0];

u = createinput(frequencies,amps,sincos,t);
y = out(t,u);

[L, roots] = stableFilter(n, frequencies);
zeta_matrix = createmodel(y, u, t, n, m, L);
[theta, error] = normalEqn(zeta_matrix, y);

a_coeffs = L(2:end)' + theta(1:(end - m - 1));  % a1 = 6, a2=11, a3=6
b_coeffs = theta(end - m : end);                % b0 = 1, b1=-3, b0=2


y_hat = zeta_matrix*theta;

figure;
subplot(2,1,1);
plot(t,y,t,y_hat);
xlabel('Time');
ylabel('Value');
title('Actual output - Estimation over time');
legend('Actual', 'Estimation');

subplot(2,1,2);
plot(t,y-y_hat,'g');
xlabel('Time');
ylabel('Error');
title('Error over time');

fprintf('Training completed.\n');
fprintf('Press any key to see the optimized coefficients.\n');
pause;

%% Making coefficients global variables
% Actual values: 
% a1 = 6, a2=11, a3=6
% b0 = 1, b1=-3, b0=2

global a1; a1 = a_coeffs(1);
global a2; a2 = a_coeffs(2);        
global a3; a3 = a_coeffs(3);

global b0; b0 = b_coeffs(1);
global b1; b1 = b_coeffs(2);
global b2; b2 = b_coeffs(3);


fprintf('Optimized Coefficients:\n');
fprintf('\t\tActual\t\tEstimation\n');
fprintf('a1: \t\t6\t\t%f\n',a1);
fprintf('a2: \t\t11\t\t%f\n',a2);
fprintf('a3: \t\t6\t\t%f\n',a3);
fprintf('b0: \t\t1\t\t%f\n',b0);
fprintf('b1: \t\t-3\t\t%f\n',b1);
fprintf('b0: \t\t2\t\t%f\n',b2);

fprintf('Press any key to continue.\n');
pause;
%% =========== Part 5: Testing with ode  ==================================
fprintf('Simulation with ode for optimized parameters.....\n');
% input u = sin(t) + 0.1*cos(2*t);
dt = 0.0001;        % No need to take very small dt here
t = 0:dt:10;
u = sin(t)+0.1*cos(2*t);
u = u';
y_real = out(t,u);
initialvector = [0;0;0];

[t,y] = ode45(@stateEquations_offline, t , initialvector);
y_hat = y(:,1);

figure;
subplot(2,1,1);
plot(t,y_real,t,y_hat);
xlabel('Time');
ylabel('Value');
title('Actual output - Estimation over time');
legend('Actual', 'Estimation');

subplot(2,1,2);
plot(t,y_real-y_hat,'g');
xlabel('Time');
ylabel('Error');
title('Error over time');
