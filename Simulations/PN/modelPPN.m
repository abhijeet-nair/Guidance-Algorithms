function dX = modelPPN(t,X,vp_d,vt_d,alpt_d,N,CT)
    % X = [xp, yp, vp, alpp, xt, yt, vt, alpt, R, tht]
    %     [ 1,  2,  3,    4,  5,  6,  7,    8, 9,  10]

    dX = zeros(size(X));
    
    Vp = X(3);
    alpp = X(4);
    Vt = X(7);
    alpt = X(8);
    R = X(9);
    tht = X(10);

    
    Vtht = Vt*sin(alpt - tht) - Vp*sin(alpp - tht);
    if CT > 0
        alpt_d = CT*Vtht/R;
    elseif CT < 0
        if abs(Vtht) < 5e-1
            alpt_d = CT;
        else
            alpt_d = abs(CT)/(Vtht*Vt);
        end
    end
    
    ap = N*Vp*Vtht/R;
    alpp_d = ap/Vp;
    
    fprintf('t = %.4f\t ap = %.4f\n',t,ap)

    dX(1) = Vp*cos(alpp);
    dX(2) = Vp*sin(alpp);
    dX(3) = vp_d;
    dX(4) = alpp_d;
    dX(5) = Vt*cos(alpt);
    dX(6) = Vt*sin(alpt);
    dX(7) = vt_d;
    dX(8) = alpt_d;
    dX(9) = Vt*cos(alpt - tht) - Vp*cos(alpp - tht);
    dX(10) = Vtht/R;
end