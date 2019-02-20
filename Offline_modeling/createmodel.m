function zeta = createmodel(y, u, t, n, m, L)
%% This function creates a (n, m) model - zeta matrix
% n: degree of output in DE
% m: degree of input in DE

y_matrix = [];
u_matrix = [];

for i=n-1:-1:0
    helper_y = zeros(1,i);
    sys1 = tf([-1 helper_y], L);
    y_matrix =[y_matrix lsim(sys1,y,t)];
end

for i = m:-1:0
    helper_u = zeros(1,i);
    sys2 = tf([1 helper_u], L);
    u_matrix = [u_matrix lsim(sys2,u,t)];
end

zeta = [y_matrix u_matrix];

end