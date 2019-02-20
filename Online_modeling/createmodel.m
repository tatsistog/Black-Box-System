function tables = createmodel(n, m, L)
%% This function creates a (n, m) model - zeta matrix
% n: degree of output in DE
% m: degree of input in DE
H_y = [];   H_u = [];

counter = 1;
for i=n-1:-1:0
    
    helper_y = zeros(1,n);
    helper_y(counter) = -1;
    H_y = [H_y; helper_y];
    
    counter = counter + 1;
end

[A,B,C,D] = tf2ss(H_y, L);
    
tables(1).A = A;
tables(1).B = B;
tables(1).C = C;
tables(1).D = D;
    

counter = 1;
for i = m:-1:0
    
    helper_u = zeros(1,m+1);
    helper_u(counter) = 1;
    H_u = [H_u; helper_u];
    
    counter = counter + 1;
end

[A,B,C,D] = tf2ss(H_u, L);
    
tables(2).A = A;
tables(2).B = B;
tables(2).C = C;
tables(2).D = D;

end