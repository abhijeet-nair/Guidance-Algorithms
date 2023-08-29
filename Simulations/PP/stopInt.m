function [value, isterminal, direction] = stopInt(t, X)
%     value = (abs(X(1) - X(5)) < 1e-1) & (abs(X(2) - X(6)) < 1e-1);
%     R = sqrt((X(6) - X(2))^2 + (X(5) - X(1))^2);
    R = X(9);
    value = (R < 0.1);
    isterminal = 1;
    direction = 0;
end