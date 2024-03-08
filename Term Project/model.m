function dX = model(t,X)
    % X = [xp, yp, zp, vp, alp_p, gma_p, xt, yt, vt, alp_t]
    dX = zeros(size(X));
    
    U       = guid_cmd();
    Vp_d    = U(1);
    alp_p_d = U(2);
    gma_p_d = U(3);
    
    dX(1)  = X(4)*cos(X(6))*cos(X(5));
    dX(2)  = X(4)*cos(X(6))*sin(X(5));
    dX(3)  = X(4)*sin(X(6));
    dX(4)  = Vp_d;
    dX(5)  = alp_p_d;
    dX(6)  = gma_p_d;
    dX(7)  = X(9)*cos(X(10));
    dX(8)  = X(9)*cos(X(10));
    dX(9)  = Vt_d;
    dX(10) = alp_t_d;
end