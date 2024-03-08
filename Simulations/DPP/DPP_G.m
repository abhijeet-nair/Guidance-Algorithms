function alpp_d = DPP_G(t,alpp,tht,Vtht,R,K,del)
    t1 = tht + del - alpp;

%     if t < 0.5
%         alpp_d = K*t1;
%     else
        alpp_d = K*t1 + Vtht/R;
%     end
end