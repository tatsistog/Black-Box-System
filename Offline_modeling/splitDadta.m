function [y_train, y_test, zeta_train, zeta_test, time_train, time_test] = splitDadta(y, zeta_matrix, time)
%% 70 percent training set - 30 percent test set
perm_vector = randperm(length(y));
y_perm = y(perm_vector);
zeta_perm = zeta_matrix(perm_vector,:);
time_perm = time(perm_vector);

N = (length(y) - 1)*0.7;

y_train = y_perm(1:N);
y_test = y_perm((N+1):end);

zeta_train = zeta_perm(1:N,:);
zeta_test = zeta_perm((N+1):end,:);

time_train = time_perm(1:N);
time_test = time_perm((N+1):end);

end