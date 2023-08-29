function [state_dot] = state_equations(X, a_lat)
    global Alpha_p;

    Xt_dot = X(3);
    Yt_dot = X(4);
    Vxt_dot = 0.0;
    Vyt_dot = 0.0;
    
    Xp_dot = X(7);
    Yp_dot = X(8);
    Vxp_dot = -a_lat*sin(Alpha_p);
    Vyp_dot =  a_lat*cos(Alpha_p);
    
    state_dot = [Xt_dot; Yt_dot; Vxt_dot; Vyt_dot; Xp_dot; Yp_dot; Vxp_dot; Vyp_dot];
    
end

