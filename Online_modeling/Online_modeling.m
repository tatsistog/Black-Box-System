%% Togkousidis Anastasis
% AEM: 8920
%% ========== Part 1: Initialization ======================================
clc; clear all; 

%% ========== Part 2: Global Variables ====================================

global tables_struct;
global n;
global m;
global y;
global time;

%% ========== Part 3: Input - Output ======================================
dt = 0.0001;
time = (0:dt:20)';
u = sin(time)+ 0.5*cos(2*time) + 2*cos(3*time) + 1.5*sin(5*time) + cos(7*time);
y = out(time,u);
[y_train, y_test,u_train, u_test, time_train, time_test] = splitData(y,time,u);

fprintf('Input and output created. Press any key to start training and testing.\n');
beep;
pause;

%% ========== Part 4: Online Modeling =====================================

n_max = 5;
m_max = n_max;
test_error_matrix = Inf(n_max, m_max);

fprintf('Training...... (This may take up to 5 minutes).\n');

figure(1); hold on;
figure(2); hold on;
counter = 1;

for i = 1:1:n_max
    for j = 0:1:i-1
        
        n = i; m = j;
        L = stableFilter(i);
        tables_struct = createmodel(i, j, L);
        
        % Training
        initialvector = createInitialVector(n,m);
        [~ , out_train] = ode45(@stateEquations_train, time_train , initialvector);
        theta_trained = out_train(end,2*n+1:2*n+n+m+1)';
        y_hat = createEstimation(out_train(:,1:2*n), y_train, u_train, theta_trained);
        
        figure(1);
        subplot(3,5,counter);
        plot(time_train(1:length(y_hat)), y_train(1:length(y_hat)) - y_hat);
        title(['n = ', num2str(n),' m = ', num2str(m)]);
        hold on;
        
        % Testing
        initialvector = out_train(end,1:2*n)';
        [~ , out_test] = ode45(@stateEquations_test, time_test , initialvector);
        y_hat = createEstimation(out_test, y_test, u_test, theta_trained);
        
        figure(2);
        subplot(3,5,counter);
        plot(time_test(1:length(y_hat)), y_test(1:length(y_hat)) - y_hat);
        title(['n = ', num2str(n),' m = ', num2str(m)]);
        hold on;
        
        
        % Calculating mean square error
        test_error_matrix(i,j+1) = computeTestError(y_test,y_hat);
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
beep;
pause;

%% ========== Part 5: Training for optimized n, m =========================
 
fprintf('In this part we re-train theta for optimized n, m in order to take more accurate result.\n');
fprintf('Training......\n');

% Initialization
dt = 0.0001;
time = (0:dt:100)';
u = sin(time)+ 0.5*cos(2*time) + 2*cos(3*time) + 1.5*sin(5*time) + cos(7*time);
y = out(time,u);
time_train = time;

L = stableFilter(n);
tables_struct = createmodel(n, m, L);
initialvector = createInitialVector(n,m);

% Training
[~ , out_train] = ode45(@stateEquations_train, time_train , initialvector);
theta_trained = out_train(end,2*n+1:2*n+n+m+1)';
theta = theta_trained;
a_coeffs = L(2:end)' + theta(1:(end - m - 1));
b_coeffs = theta(end - m : end);                

fprintf('Training completed.\n');
fprintf('Press any key to see the optimized coefficients.\n');
beep;
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
beep;
pause;


%% ========== Part 6: Online simulation for optimized coefficients ========
% For this simulation, I use the code that I have already written for
% offline simulation

fprintf('Simulation for optimized parameters.....\n');

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
