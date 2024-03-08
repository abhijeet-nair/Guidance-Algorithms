function dX = modelPP(t,X,vp_d,vt_d,alpt_d,K,CT)
    % X = [xp, yp, vp, alpp, xt, yt, vt, alpt] %, R, tht, VR, Vtht]
    %     [ 1,  2,  3,    4,  5,  6,  7,    8] %, 9,  10, 11,   12]

    dX = zeros(size(X));

%     tht = atan((X(6) - X(2))/(X(5) - X(1)));
%     tht = atan2(X(6) - X(2),X(5) - X(1));
%     R = sqrt((X(6) - X(2))^2 + (X(5) - X(1))^2);
%     tht = X(10);
    R = X(9);
%     if X(4) < 0
%         alpp = 2*pi - rem(X(4),2*pi);
%     else
%         alpp = rem(X(4),2*pi);
%     end
%     if X(10) < 0
%         tht = 2*pi - rem(X(10),2*pi);
%     else
%         tht = rem(X(10),2*pi);
%     end
    alpp = X(4);
    tht = X(10);
    
    Vtht = X(7)*sin(X(8) - tht) - X(3)*sin(X(4) - tht);
    if CT ~= 0
        alpt_d = CT*Vtht/R;
    end
    
%     t1 = tht - alpp;
%     alpp_d = Vtht/R;
    alpp_d = PP_G(t,alpp,tht,Vtht,R,K);

%     if strcmp(G,'PP')
%         if t < 0.5
% %             alpp_d = K*rem(tht - rem(X(4),2*pi),2*pi);
%             alpp_d = K*t1;
%         else
% %             alpp_d = K*rem(tht - rem(X(4),2*pi),2*pi) + Vtht/R;
%             alpp_d = K*t1 + Vtht/R;
%         end
%     else
%         alpp_d = 0;
%     end
    
%     fprintf('t = %.4f\ttheta = %.4f\trem = %.4f\tR = %.4f\n',t,rad2deg(tht),rad2deg(tht - rem(X(4),2*pi)),R)
    fprintf('t = %.4f\t ap = %.4f\n',t,X(3)*alpp_d)

    dX(1) = X(3)*cos(X(4));
    dX(2) = X(3)*sin(X(4));
    dX(3) = vp_d;
    dX(4) = alpp_d;
    dX(5) = X(7)*cos(X(8));
    dX(6) = X(7)*sin(X(8));
    dX(7) = vt_d;
    dX(8) = alpt_d;
    dX(9) = X(7)*cos(X(8) - tht) - X(3)*cos(X(4) - tht);
    dX(10) = Vtht/R;
end