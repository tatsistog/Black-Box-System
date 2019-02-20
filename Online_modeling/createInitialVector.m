function initialvector = createInitialVector(n,m)

phi_init = zeros(2*n,1);
theta_init = ones(n+m+1,1);
P_init = eye(n+m+1);

initialvector = [phi_init; theta_init; P_init(:)];

end