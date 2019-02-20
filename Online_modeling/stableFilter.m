function L = stableFilter(degree)
roots = -2*ones(degree,1);
L = poly(roots);
end