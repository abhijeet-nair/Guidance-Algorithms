function [state_dot] = state_equations(X, a_lat)
    global Alpha_p omega
    
    R_target = norm(X(1:2));
    A_target = omega^2*R_target;
    psi = X(9);
    
    Xt_dot = X(3);
    Yt_dot = X(4);
    Vxt_dot = -A_target*cos(psi);
    Vyt_dot = -A_target*sin(psi);
    
    Xp_dot = X(7);
    Yp_dot = X(8);
    Vxp_dot = -a_lat*sin(Alpha_p);
    Vyp_dot =  a_lat*cos(Alpha_p);
    
    Alpha_t_dot = omega;
    
    state_dot = [Xt_dot; Yt_dot; Vxt_dot; Vyt_dot; Xp_dot; Yp_dot; Vxp_dot; Vyp_dot; Alpha_t_dot];
    
end

