function [L, roots] = stableFilter(degree,freqs)
mainfreq = max(freqs);
main_angular_freq =  2*pi*mainfreq;
roots = zeros(degree,1);

for i = 1:1:degree
    roots(i) = -(main_angular_freq + 100);
end

L = poly(roots);
end