function u = createinput(f,amps,sincos,t)
%% sincos array: 1 for sin, 0 for cos
n = length(f);
u = zeros(size(t));
for i=1:1:length(t)
    sum = 0;
    for j = 1:1:n
        if (sincos(j) == 1)
            sum = sum + amps(j)*sin(2*pi*f(j)*t(i));
        else
            sum = sum + amps(j)*cos(2*pi*f(j)*t(i));
        end
    end
    u(i) = sum;
end

end