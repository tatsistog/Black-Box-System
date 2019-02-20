function y_hat = createEstimation(out_test, y_test, u_test, theta_trained)
%% Global variables
global n;
global m;
global tables_struct;

%% Initialization
y_hat = zeros(size(out_test,1),1);

C_y = tables_struct(1).C;
C_u = tables_struct(2).C;

D_y = tables_struct(1).D;
D_u = tables_struct(2).D;

phi_vector = zeros(n+m+1,1);

%% Creating output

for i = 1:1:size(out_test,1)
    
    y_curr = y_test(i);
    u_curr = u_test(i);
    
    phi_sv_y = out_test(i,1:n)';
    phi_sv_u = out_test(i,n+1:end)';
    
    phi_vector(1:n) = C_y * phi_sv_y + D_y * y_curr; 
    phi_vector(n+1:end) = C_u * phi_sv_u + D_u * u_curr; 
    
    
    y_hat(i) = (theta_trained') * phi_vector;
end

end