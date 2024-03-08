function alpp_d = PP_G(t,alpp,tht,Vtht,R,K)
    t1 = tht - alpp;
%     fprintf('t = %.4f\tt1 = %.4f\n',t,t1)
%     if t < 0.5
%         alpp_d = K*t1;
%     else
        alpp_d = K*t1 + Vtht/R;
%     end
end