function [ x ] = rrkk(x0,u)
    global dt
    h=dt;
    k1=state_equations(x0, u);
    k2=state_equations(x0 + k1.*(0.5*h),u);
    k3=state_equations(x0 + k2.*(0.5*h),u);
    k4=state_equations(x0 + k3.*h,u);
    k = (k1 +k2.*2 +k3.*2 +k4)/6;
    x = x0  + k.*h;
end